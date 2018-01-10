  describe User do

  let!(:user) do
    User.create(email: 'jane@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

    it 'authenticates when given a valid email address and password' do
      authenticated_user = User.authenticate(user.email, user.password)
      expect(authenticated_user).to eq user
    end

    it 'does not authenticate when given incorrect details' do
      expect(User.authenticate(user.email, 'wrong_password')).to be_nil
    end

    describe '#generate_token' do

      it 'generates a token and saves it as a property' do
        expect { user.generate_token }.to change { user.password_token }
      end

      it 'saves a timestamp when the token is generated' do
        expect { user.generate_token }.to change { user.password_token_time }
      end

      it 'saves the time when the token was generated' do
        Timecop.freeze do
          user.generate_token
          expect(user.password_token_time).to eq Time.now
        end
      end
    end

    describe '.find_by_valid_token' do
      it 'returns a valid user' do
        user = User.create(email:'mia@test.com', password: 'test', password_confirmation: 'test')
        user.generate_token
        expect(User.find_by_valid_token(user.password_token)).to eq user
      end

      it "can't find a userwhen the timestamp is over an hour old" do
        user = User.create(email:'luc@test.com', password: 'test', password_confirmation: 'test')
        user.generate_token
        Timecop.travel(60*60 + 1) do
          expect(User.find_by_valid_token(user.password_token)).to be_nil
        end
      end

      it 'returns nill if no valid user' do
        user = User.create(email:'mia@test.com', password: 'test', password_confirmation: 'test')
        user.generate_token
        expect(User.find_by_valid_token('something else')).to be_nil
      end
    end
  end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録できる' do
      it 'nickname,email,password,password_confirmation,last_name,first_name,last_name_reading,first_name_reading,birth_dayがある場合登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録できない' do
      it 'nicknameがないと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailがないと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複してたら登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailには@がないと登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordがないと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは6文字以上でないと登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordは半角英数混合出ないと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
      end
      it 'passwordとpassword_confirmationが一致してないと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '1234abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名前(全角)はlast_nameとfirst_nameがないと登録できない' do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank","First name can't be blank")
      end
      it '名前(全角)は全角でないと登録できない' do
        @user.last_name = 'test'
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.", "First name is invalid. Input full-width characters.")
      end
      it '名前(カナ)はlast_name_readingとfirst_name_readingがないと登録できない' do
        @user.last_name_reading = ''
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank","First name reading can't be blank")
      end
      it '名前(カナ)はカタカタでないと登録できない' do
        @user.last_name_reading = 'たろう'
        @user.first_name_reading = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading is invalid. Input full-width katakana characters.", "First name reading is invalid. Input full-width katakana characters.")
      end
      it '生年月日がないと登録できない' do
        @user.birth_day = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end

    end
  end
end

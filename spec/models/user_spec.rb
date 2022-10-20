require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "新規登録/ユーザー情報" do
    context '新規登録がうまくいくとき' do
      it "nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "last_name、first_nameが全角（漢字・カタカナ・ひらがな）であれば登録できる" do
        @user.last_name = '漢字カタカナひらがな'
        @user.first_name = '漢字カタカナひらがな'
        expect(@user).to be_valid
      end
      it "last_name_kana、first_name_kanaが全角カタカナであれば登録できる" do
        @user.last_name_kana = 'カタカナ'
        @user.first_name_kana = 'カタカナ'
        expect(@user).to be_valid
      end
      it "password、password_confirmationが6文字以上の半角英数字であれば登録できる" do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "登録されたemailでは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it "emailに@を含まないと登録できない" do
        @user.email = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it "password空では登録できない" do
        @user.password = nil
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "passwordが6文字以上でないと登録できない" do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it "passwordは半角数字だけでは登録できない" do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "passwordは半角英字だけでは登録できない" do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "passwordは全角英数字混合では登録できない" do
        @user.password = '１２３ａｂｅ'
        @user.password_confirmation = '１２３ａｂｅ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "passwordとpassword_confirmationが一致しないと登録できない" do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "お名前(全角)は、名字が空だと登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it "お名前(全角)は、名前が空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it " お名前(全角)は、全角数字では登録できない" do
        @user.first_name = '１'
        @user.last_name = '１'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid", "First name is invalid"
      end
      it " お名前(全角)は、全角英字では登録できない" do
        @user.first_name = 'ａ'
        @user.last_name = 'ａ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid", "First name is invalid"
      end
      it " お名前(全角)は、半角数字では登録できない" do
        @user.first_name = '1'
        @user.last_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid", "First name is invalid"
      end
      it " お名前(全角)は、半角英字では登録できない" do
        @user.first_name = 'a'
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid", "First name is invalid"
      end
      it " お名前(全角)は、半角カナでは登録できない" do
        @user.first_name = 'ｱ'
        @user.last_name = 'ｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid", "First name is invalid"
      end
      it "お名前カナ(全角)は、名字が空では登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it "お名前カナ(全角)は、名前が空では登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it "お名前カナ(全角)は、全角（漢字）では登録できない" do
        @user.first_name_kana = '漢字'
        @user.last_name_kana = '漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid", "First name kana is invalid"
      end
      it "お名前カナ(全角)は、全角（ひらがな）では登録できない" do
        @user.first_name_kana = 'ひらがな'
        @user.last_name_kana = 'ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid", "First name kana is invalid"
      end
      it "お名前カナ(全角)は、全角（英字）では登録できない" do
        @user.first_name_kana = 'ａ'
        @user.last_name_kana = 'ａ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid", "First name kana is invalid"
      end
      it "お名前カナ(全角)は、全角（数字）では登録できない" do
        @user.first_name_kana = '１'
        @user.last_name_kana = '１'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid", "First name kana is invalid"
      end
      it "生年月日ががないと登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end

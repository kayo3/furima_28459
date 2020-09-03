require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "(共通)nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが6文字以上かつ半角英数字混合であれば登録できる" do
        @user.password = "012abC"
        @user.password_confirmation = "012abC"
        expect(@user).to be_valid
      end
      it "ユーザー本名は全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.last_name = "漢字ひらがなカタカナ"
        @user.first_name = "漢字ひらがなカタカナ"
        expect(@user).to be_valid
      end
      it "ユーザー本名のフリガナは全角（カタカナ）であれば登録できる" do
        @user.last_name_kana = "カタカナ"
        @user.first_name_kana = "カタカナ"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "emailに＠がなければ登録できない" do
        @user.email = "abc.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは「＠」必須です")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it "passwordが半角英数字混合でなければ登録できない" do
        @user.password = "パスワード"
        @user.password_confirmation = "パスワード"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字混合で入力して下さい")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）は半角英数字混合で入力して下さい")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
      it "last_nameが空だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it "last_nameが半角だと登録できない" do
        @user.last_name = "ﾊﾝｶｸ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は全角（漢字・ひらがな・カタカナ）で入力して下さい")
      end
      it "first_nameが空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "first_nameが半角だと登録できない" do
        @user.first_name = "ﾊﾝｶｸ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角（漢字・ひらがな・カタカナ）で入力して下さい")
      end
      it "last_name_kanaが空だと登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（フリガナ）を入力してください")
      end
      it "last_name_kanaが半角だと登録できない" do
        @user.last_name_kana = "katakana"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（フリガナ）は全角カタカナで入力して下さい")
      end
      it "first_name_kanaが空だと登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（フリガナ）を入力してください")
      end
      it "first_name_kanaが半角だと登録できない" do
        @user.first_name_kana = "katakana"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（フリガナ）は全角カタカナで入力して下さい")
      end
    end
  end
end

# bundle exec rspec spec/models/user_spec.rb
# @user.errors
# @user.errors.full_messages
# binding.pry
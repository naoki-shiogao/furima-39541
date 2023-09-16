require 'rails_helper'

RSpec.describe OrderForm, type: :model do

  before do
    @order_form = FactoryBot.build(:order_form)
  end

  describe '配送先の情報' do
    context '配送先の情報を登録できる' do
      it '配送先の情報が全て入力されていると登録できる' do
        expect(@order_form).to be_valid
      end
      it '建物名が空でも登録できる' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end

    context '配送先の情報を登録できない' do
      it '郵便番号が空だと登録できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Postal code can't be blank")
      end
      it '郵便番号は（3桁ハイフン4桁）出ないと登録できない' do
        @order_form.postal_code = '0001111'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県が"---"だと登録できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Prefecture can't be blank")
      end
      it '市区町村が空だと登録できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("City can't be blank")
      end
      it '番地が空だと登録できない' do
        @order_form.house_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空だと登録できない' do
        @order_form.telephone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号は9桁以下では登録できない' do
        @order_form.telephone_number = '000111222'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Telephone number is invalid")
      end
      it '電話番号は12桁以上では登録できない' do
        @order_form.telephone_number = '000011112222'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Telephone number is invalid")
      end
      it '電話番号はハイフンがあると登録できない' do
        @order_form.telephone_number = '000-1111-2222'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Telephone number is invalid")
      end
    end
  end
end

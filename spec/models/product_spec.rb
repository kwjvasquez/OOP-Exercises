# frozen_string_literal: true

require_relative "../../models/product"
require_relative "../factories/product_factory"

RSpec.describe Product do
  subject { Product.new }

  let(:info_product) { attributes_for(:product) }
  let(:product) { subject.create(**info_product) }
  let(:product_id) { product[:id] }

  before do
    product
  end

  describe "#create" do
    context "when all arguments are passed" do
      let(:info_new_product) { attributes_for(:product) }

      context "when the id product does not exist" do
        it "adds the product" do
          expect { subject.create(**info_new_product) }.to change(subject, :count).by(1)
        end
      end

      context "when the id product already exists" do
        it "does not add the product" do
          info_product[:id] = product_id
          expect { subject.create(**info_product) }.to change(subject, :count).by(0)
        end
      end
    end

    context "when an optional argument is not passed" do
      let(:info_product) { attributes_for(:product).except(:description) }

      it "adds the product without the attribute" do
        expect(product[:description]).to be_nil
      end
    end

    context "when a required argument is not passed" do
      it "raises an error" do
        info_product.delete(:id)
        expect { subject.create(**info_product) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#find" do
    context "when the product exists" do
      it "returns the information" do
        expect(subject.find(id: product_id)).to eq(info_product)
      end
    end

    context "when the product does not exist" do
      let(:product_id) { 999 }

      it "returns nil" do
        expect(subject.find(id: product_id)).to be_nil
      end
    end
  end

  describe "#update" do
    let(:update_info) { attributes_for(:product).except(:id, :brand, :quantity) }

    context "when the product exists" do
      it "updates the information" do
        expect { subject.update(id: product_id, **update_info) }.to change { product }
      end

      it "changes the products list" do
        expect { subject.update(id: product_id, **update_info) }.to change { subject.all }
      end
    end

    context "when the product does not exist" do
      let(:product_id) { 999 }

      it "does not change the products list" do
        expect { subject.update(id: product_id, **update_info) }.not_to change { subject.all }
      end

      it "returns nil" do
        expect(subject.update(id: product_id, **update_info)).to be_nil
      end
    end
  end
end


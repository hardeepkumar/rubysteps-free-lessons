require 'rspec'

class Order
  def initialize(customer_name)
    @customer_name = customer_name
    @items = []
  end

  def purchase(name, quantity, price)
    @items << {name: name, quantity: quantity, price: price}
  end

  def finalize
    @finalized_at = Time.now
  end

  def print_receipt
    puts receipt_as_string
  end

  def receipt_as_string
     lines = []
     lines << "Purchase receipt for #{@customer_name}"
#     lines << "Time: #{@finalized_at}"
#
#     total = 0
#     @items.each do |i|
#       item_price = i[:price] * i[:quantity]
#       total += item_price
#
#       item_tax = item_price * 0.07
#       total_tax = total * 0.07
#
#       lines << "#{i[:name]}: #{i[:quantity]} @ $#{i[:price]}; $#{item_price}"
#     end
#
#     lines << "Total: $#{total}"
#
     lines.join("\n")
  end
end

describe Order, '#print_receipt' do
  let(:order) { Order.new 'Joe' }
  let(:receipt) { order.receipt_as_string }

  before do
    order.purchase 'shoes', 2, 15.0
    order.purchase 'shirt', 3, 12.0
    order.purchase 'hat', 1, 18.0
    order.finalize
  end

  it "includes the customer's name" do
    expect(receipt).to include('Joe')
  end

  it "includes the time the order was finalized"

  it "includes a line item for each item purchased"

  it "includes the total price"
end

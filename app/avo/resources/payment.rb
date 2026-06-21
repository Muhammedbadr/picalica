class Avo::Resources::Payment < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :order_id, as: :number
    field :amount, as: :number
    field :name, as: :text
    field :info, as: :text
    field :currency, as: :text
    field :payment_method_id, as: :number
    field :stripe_charge_id, as: :number
    field :order, as: :belongs_to
  end
end

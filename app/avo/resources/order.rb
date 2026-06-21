class Avo::Resources::Order < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :status, as: :text
    field :user, as: :belongs_to
    field :order_items, as: :has_many
    field :products, as: :has_many, through: :order_items
    field :payment, as: :has_one
  end
end

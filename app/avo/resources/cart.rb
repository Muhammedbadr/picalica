class Avo::Resources::Cart < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :user, as: :belongs_to
    field :cart_items, as: :has_many
    field :products, as: :has_many, through: :cart_items
  end
end

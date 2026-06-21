class Avo::Resources::License < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :product_id, as: :number
    field :price, as: :number
    field :title_name, as: :text
    field :stripe_price_id, as: :text
    field :product, as: :belongs_to
  end
end

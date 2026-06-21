class Avo::Resources::Category < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :subcategories, as: :has_many
    field :products, as: :has_many, through: :subcategories
  end
end

class Avo::Resources::Subcategory < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :category_id, as: :number
    field :name, as: :text
    field :category, as: :belongs_to
    field :products, as: :has_many
  end
end

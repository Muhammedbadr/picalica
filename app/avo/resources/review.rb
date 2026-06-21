class Avo::Resources::Review < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :product_id, as: :number
    field :name, as: :text
    field :content, as: :textarea
    field :work_quality, as: :number
    field :communication, as: :number
    field :ease_of_use, as: :number
    field :documentation_quality, as: :number
    field :user, as: :belongs_to
    field :product, as: :belongs_to
  end
end

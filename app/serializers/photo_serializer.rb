class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :url
end

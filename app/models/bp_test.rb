# == Schema Information
#
# Table name: bp_tests
#
#  id           :integer          not null, primary key
#  image        :string(255)
#  pdf          :string(255)
#  int          :integer
#  json         :json
#  markdown     :text
#  text         :text
#  created_at   :datetime
#  updated_at   :datetime
#  enum         :string(255)
#  approved_at  :datetime
#  validated_at :datetime
#

class BpTest < ActiveRecord::Base
  include CommonExtensions

  mount_uploader :image, ImageUploader
  mount_uploader :pdf, PdfUploader

  enum enum: %i(foo bar baz)

  markdown_attr :markdown

  add_to_dashboard weight: 0, size: 2
  set_shared_policy PublicModelPolicy

  def caption
    "Test ##{id}"
  end

  attr_toggle :approve, off: :revocate
  attr_toggle :validate
end

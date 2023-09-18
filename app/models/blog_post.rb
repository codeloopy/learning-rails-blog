class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :sorted, -> { order(published_at: :desc, updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) } #ruby lambda, a ruby lambda will allow rails to run this query when needed and not only at boot time
  scope :published, -> { where('published_at <= ?', Time.current) } #ruby lambda, a ruby lambda will allow rails to run this query when needed and not only at boot time
  scope :scheduled, -> { where('published_at > ?', Time.current) } #ruby lambda, a ruby lambda will allow rails to run this query when needed and not only at boot time

  def draft?
    published_at.nil?
  end

  def published?
    published_at && published_at <= Time.current
  end

  def scheduled?
    published_at && published_at > Time.current
  end
end

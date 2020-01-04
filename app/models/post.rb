class Post < ApplicationRecord
  validates :title, presence: true , length: {maximum: 40}

  has_rich_text :content
  belongs_to :user

  has_many :comments

  enum genre: { worry: 0, skill: 1, foreign: 2 }

  validate :validate_content_attachment_byte_size
  validate :validate_content_attachments_count

  ONE_KILOBYTE = 1024
  MAX_MEGA_BYTES = 0.5
  MAX_CONTENT_ATTACHMENT_BYTE_SIZE = MAX_MEGA_BYTES * 1_000 * ONE_KILOBYTE
  MAX_CONTENT_ATTACHMENTS_COUNT = 2

  private

  def validate_content_attachment_byte_size
    content.body.attachables.grep(ActiveStorage::Blob).each do |attachable|
      if attachable.byte_size > MAX_CONTENT_ATTACHMENT_BYTE_SIZE
        errors.add(
          :base,
          :content_attachment_byte_size_is_too_big,
          max_content_attachment_mega_byte_size: MAX_MEGA_BYTES,
          bytes: attachable.byte_size,
          max_bytes: MAX_CONTENT_ATTACHMENT_BYTE_SIZE
        )
      end
    end  
  end

  def validate_content_attachments_count
    if content.body.attachables.grep(ActiveStorage::Blob).count > MAX_CONTENT_ATTACHMENTS_COUNT
      errors.add(
        :content,
        :attachments_count_is_too_big,
        max_content_attachments_count: MAX_CONTENT_ATTACHMENTS_COUNT
      )
    end
  end

end

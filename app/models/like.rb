class Like < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :fish_catch, counter_cache: true

  # two callbacks: After a like has been created, we'll broadcast and update TurboStream asynchrously.
  # to the activity channel and the target we're updating is the DOM node for the catch's like count.
  after_create_commit -> {
    broadcast_update_later_to "activity",
      target: "#{dom_id(self.fish_catch)}_likes_count",
      html: self.fish_catch.likes_count
}

after_destroy_commit -> {
  broadcast_update_later_to "activity",
  target: "#{dom_id(self.fish_catch)}_likes_count",
  html: self.fish_catch.likes_count,
  locals: { like: nil }
}
end

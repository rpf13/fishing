class FishCatch < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :bait
  belongs_to :user
  has_many :likes, dependent: :destroy

  # this is a callback - inside the model. It is triggered after a new fish catch is created
  # and broadcasts a message to the activity channel, which is then received by the activity.
  # later_to will make sure it is sent to a background job using ActionJob. It will also work
  # without, but it is better to use it, since it will not block the main thread.
  after_create_commit -> {
    broadcast_prepend_later_to "activity", target: "catches",
                          partial: "activity/fish_catch"
                          # locals is the parameter, which the partial requires as argument
                          # however, it is not necessary to pass the locals parameter, since
                          # it is automatically merged in the locals hash, rails figures this
                          # out based on the class name.

                          # locals: { fish_catch: self }
  }

  # this is a callback - inside the model. It is triggered after a fish catch is updated
  after_update_commit -> {
    broadcast_replace_later_to "activity",
                          target: "#{dom_id(self)}_details",
                          partial: "activity/catch_details"
  }

  # this is a callback - inside the model. It is triggered after a fish catch is destroyed
  # it automatically broadcasts a message to the activity channel, which is then received by the activity
  # channel and removes the fish catch from the list of catches
  # It automatically sets teh target to the DOM id of the fish catch that was destroyed.
  after_destroy_commit -> {
    broadcast_remove_to "activity"
  }

  SPECIES = [
    "Brown Trout",
    "Rainbow Trout",
    "Lake Trout",
    "Largemouth Bass",
    "Smallmouth Bass",
    "Bluegill",
    "Walleye"
  ]

  validates :species, presence: true,
            inclusion: {
              in: SPECIES,
              message: "%{value} is not a valid species"
            }

  validates :weight, :length,
            presence: true,
            numericality: { greater_than: 0 }

  attr_accessor :my_like

  scope :with_species, ->(species) {
    where(species: species) if species.present?
  }

  scope :with_bait_name, ->(bait_name) {
    where(baits: {name: bait_name}) if bait_name.present?
  }

  scope :with_weight_between, ->(low, high) {
    where(weight: low..high) if low.present? && high.present?
  }
end

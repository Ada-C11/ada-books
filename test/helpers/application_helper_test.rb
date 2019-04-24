# Dee thinks that we can delete this line...
require "test_helper"

describe ApplicationHelper do
  describe "readable_date" do
    it "gives back something cool when date is valid" do
      # Arrange
      date = Date.today - 14

      # Act
      result = readable_date(date)

      # Assert
      # Check the following things:
      # 1. It has title that is the date we gave it
      # Maybe... it's a span? It has the word "ago" in it?
      # I would NOT check:
      #  - It has a class (this is very front-end/UI and likely to change)
      # Debatable:
      #  - Would I check if the method "time_ago_in_words" works correctly?
      expect(result).must_include date.to_s
      expect(result).must_include "15 days ago"
    end

    it "gives back the string [unknown] when date is nil" do
      result = readable_date(nil)
      expect(result).must_equal "[unknown]"
    end
  end
end

Feature: Tags

  Background:
    Given there are articles
    And I visit the homepage

  Scenario: Viewing the list of articles trough a tag
    Given there are tags applied to the latest article
    And the first tag is also applied to the next-to-last article

    When I select the latest article
    And I select that tag in the list of tags

    Then I should see both the latest and next-to-last articles on the tag page

    When I go back to the latest article
    And I select another tag from the list of tags

    Then I should only see the latest article on the tag page

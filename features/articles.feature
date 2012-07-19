Feature: Articles
  In order to read the articles on the website
  The articles should be listed on the frontpage and shown on a detail page

  Scenario: Viewing the latest articles
    Given there are articles
    When I visit the homepage
    Then I should see the latest articles

  Scenario: Viewing the latest article
    Given there are articles
    When I visit the homepage
    And I select the latest article
    Then I should see the full latest article

  Scenario: Viewing the next-to-last article
    Given there are articles
    When I visit the homepage
    And I select the next-to-last article
    Then I should see the full next-to-last article

  Scenario: Viewing an article from the carousel
    Given there are more articles than the latest articles
    When I visit the homepage
    Then I should see the latest articles
    And I should see the other articles in the carousel

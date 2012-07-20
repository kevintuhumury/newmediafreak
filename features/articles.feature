Feature: Articles
  In order to read the articles on the website
  The articles should be listed on the frontpage and shown on a detail page

  Background:
    Given there are articles
    When I visit the homepage

  Scenario: Viewing the latest articles
    Then I should see the latest articles

  Scenario: Viewing the latest article
    When I select the latest article
    Then I should see the full latest article

  Scenario: Viewing the next-to-last article
    When I select the next-to-last article
    Then I should see the full next-to-last article

  Scenario: Navigating between articles
    When I select the latest article
    Then I should see the full latest article

    When I navigate to the next-to-last article
    Then I should see the full next-to-last article

    When I navigate to the first article
    Then I should only be able to navigate forward

  Scenario: Viewing an article from the carousel
    Then I should see the latest articles
    And I should see the other articles in the carousel

require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test 'pdf renderer sends a pdf as file' do
    visit home_path
    click_link 'PDF'

    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="contents.pdf"', headers['Content-Disposition']
    assert_equal 'application/pdf', headers['Content-Type']
    assert_match /PDF/, page.source
  end

  test 'pdf renderer uses a specific template' do
    visit "/another.pdf"
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="contents.pdf"', headers['Content-Disposition']
    assert_equal 'application/pdf', headers['Content-Type']
    assert_match /PDF/, page.source
  end

  protected

  def headers
    page.response_headers
  end
end

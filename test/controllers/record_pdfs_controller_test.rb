require 'test_helper'

class RecordPdfsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get record_pdfs_index_url
    assert_response :success
  end

end

require 'test_helper'

class FingerprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fingerprint = fingerprints(:one)
  end

  test "should get index" do
    get fingerprints_url
    assert_response :success
  end

  test "should get new" do
    get new_fingerprint_url
    assert_response :success
  end

  test "should create fingerprint" do
    assert_difference('Fingerprint.count') do
      post fingerprints_url, params: { fingerprint: { fingerprint: @fingerprint.fingerprint } }
    end

    assert_redirected_to fingerprint_path(Fingerprint.last)
  end

  test "should show fingerprint" do
    get fingerprint_url(@fingerprint)
    assert_response :success
  end

  test "should get edit" do
    get edit_fingerprint_url(@fingerprint)
    assert_response :success
  end

  test "should update fingerprint" do
    patch fingerprint_url(@fingerprint), params: { fingerprint: { fingerprint: @fingerprint.fingerprint } }
    assert_redirected_to fingerprint_path(@fingerprint)
  end

  test "should destroy fingerprint" do
    assert_difference('Fingerprint.count', -1) do
      delete fingerprint_url(@fingerprint)
    end

    assert_redirected_to fingerprints_path
  end
end

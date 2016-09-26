require 'helper'

class VerifierTest < ActiveSupport::TestCase
  setup do
    @verifier = GlobalID::Verifier.new('muchSECRETsoHIDDEN')
  end

  test "generates URL-safe messages" do
    assert_equal "BAh7B0kiCGdpZAY6BkVUSSInZ2lkOi8vYmN4L1BlcnNvbi8xMTUxODY_ZXhwaXJlc19pbgY7AFRJIg9leHBpcmVzX2F0BjsAVDA=--fa4b8c7a28d213288fdd9b6764a5dd119a18a6fe",
      @verifier.generate("gid" => "gid://bcx/Person/115186?expires_in", "expires_at" => nil)
  end

  test "verifies URL-safe messages" do
    assert_equal({ "gid" => "gid://bcx/Person/115186?expires_in", "expires_at" => nil },
      @verifier.verify("BAh7B0kiCGdpZAY6BkVUSSInZ2lkOi8vYmN4L1BlcnNvbi8xMTUxODY_ZXhwaXJlc19pbgY7AFRJIg9leHBpcmVzX2F0BjsAVDA=--fa4b8c7a28d213288fdd9b6764a5dd119a18a6fe"))
  end

  test "verifies non-URL-safe messages" do
    assert_equal({ "gid" => "gid://bcx/Person/115186?expires_in", "expires_at" => nil },
      @verifier.verify("BAh7B0kiCGdpZAY6BkVUSSInZ2lkOi8vYmN4L1BlcnNvbi8xMTUxODY/ZXhwaXJlc19pbgY7AFRJIg9leHBpcmVzX2F0BjsAVDA=--ae5e44055262447fdbf5d5d39d5120cfa7d5fbe6"))
  end
end

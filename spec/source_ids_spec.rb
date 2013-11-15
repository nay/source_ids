# -- coding: utf-8

require "spec_helper"

describe SourceIds do
  let(:user) { User.create(:name => "user") }
  let(:group) { Group.create(:name => "group") }

  before do
    group._user_ids = [user.id]
  end

  it "_users" do
    group._users.should == [user]
  end
end

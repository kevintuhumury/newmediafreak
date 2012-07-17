require 'spec_helper'

describe Article do

  it { should deny(:title).to_be_blank }
  it { should deny(:content).to_be_blank }
  it { should deny(:image).to_be_blank }

end

require File.dirname(__FILE__) + '/../spec_helper'
require 'statum/models'

describe Team do
  it { should have_property :id   }
  it { should have_property :name   }
  it { should have_property :description   }
  it { should validate_uniqueness_of :name }
end

describe User do
  it { should have_property :id   }
  it { should have_property :email   }
  it { should have_property :name   }
  it { should have_property :login  }
  it { should have_property :hashed_password   }
  it { should have_property :salt   }
  it { should have_property :created_at   }
  it { should validate_uniqueness_of :email }
  it { should validate_uniqueness_of :login }
end

describe Item do
  it { should have_property :id   }
  it { should have_property :status   }
  it { should have_property :created_at   }
  it { should have_property :updated_on   }
  it { should validate_presence_of :status }
end

describe Comment do
  it { should have_property :id   }
  it { should have_property :body   }
  it { should have_property :email   }
  it { should have_property :name   }
  it { should have_property :login   }
  it { should have_property :url   }
  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :login }
  it { should validate_presence_of :body }
  it { should validate_presence_of :url }
end

class LicensesController < ApplicationController
  def index
    @licenses = License.all
  end
end

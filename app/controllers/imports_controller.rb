class ImportsController < ApplicationController
  def create
    file_to_import = params[:csv_file]

    ImportBattingStats.new(file_to_import).call if file_to_import.present?
  end
end

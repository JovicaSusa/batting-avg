class ImportsController < ApplicationController
  def create
    file_to_import = params[:csv_file]

    return redirect_to root_path, alert: "Please upload file" unless file_to_import.present?

    ImportBattingStats.new(file_to_import).call

    redirect_to root_path, notice: "Yay, we did it. Here are the results!"
  end
end

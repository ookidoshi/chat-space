class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'log in' do
    # この中にログインしている場合のテストを記述
      before do
        login user
      end

      context 'can save' do
      # この中にメッセージの保存に成功した場合のテストを記述
      end

      context 'can not save' do
      # この中にメッセージの保存に失敗した場合のテストを記述
      end
    end

    context 'not log in' do
    # この中にログインしていない場合のテストを記述
      before do
        get :create, params: params
      end

      

    end
  end
end
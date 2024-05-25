# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
    before_action :authenticate_request
  
    def index
      blogs = Blog.all
      render json: blogs
    end
  
    def show
      blog = Blog.find(params[:id])
      render json: blog
    end
  
    def create
      blog = Blog.new(blog_params)
      if blog.save
        render json: blog, status: :created
      else
        render json: { error: blog.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      blog = Blog.find(params[:id])
      if blog.update(blog_params)
        render json: blog
      else
        render json: { error: blog.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      blog = Blog.find(params[:id])
      blog.destroy
      head :no_content
    end
  
    private
  
    def blog_params
      params.permit(:title, :body)
    end
  
    def authenticate_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JWT.decode(header, 'iJimmy', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        render json: { error: 'Token is invalid' }, status: :unauthorized
      end
    end
  end
  
FROM nginx:alpine

# Copy only the app folder contents
COPY app/ /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


from flask import Flask
from app.routes.user_routes import user_blueprint
from app.routes.product_routes import product_blueprint
from app.routes.home_routes import home_blueprint 


def create_app():
    app = Flask(__name__)

    # Register blueprints
    app.register_blueprint(home_blueprint)  
    app.register_blueprint(user_blueprint)
    app.register_blueprint(product_blueprint)

    return app

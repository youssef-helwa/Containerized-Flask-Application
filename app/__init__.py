from flask import Flask, jsonify
from app.routes.user_routes import user_blueprint
from app.routes.product_routes import product_blueprint
from app.routes.home_routes import home_blueprint


def create_app():
    app = Flask(__name__)

    # Register blueprints
    app.register_blueprint(home_blueprint)
    app.register_blueprint(user_blueprint)
    app.register_blueprint(product_blueprint)

    @app.route('/health', methods=['GET'])
    def health_check():
        return jsonify({"status": "healthy"}), 200

    # Example error handler
    @app.errorhandler(404)
    def page_not_found(e):
        return jsonify({"error": "Page not found"}), 404

    return app


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)  # Ensure debug is False in production

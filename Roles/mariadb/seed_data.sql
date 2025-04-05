-- Create a sample table for content
CREATE TABLE IF NOT EXISTS content (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data
INSERT INTO content (title, content) VALUES
('Welcome', 'Welcome to our Angular DevOps Project!'),
('About', 'This is a demonstration of Angular with MariaDB.'),
('Feature', 'This site supports versioning and rollbacks through Jenkins.');

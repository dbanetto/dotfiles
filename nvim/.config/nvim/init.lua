-- Base configuration
require('settings')
-- Lazy & plugins
require('config.lazy')
-- Setup LSP configs
require('config.lsp-config')
-- Attempt to load the override LSP configs
-- pcall(require, 'config.override.lsp-config')
-- Enable LSPs
require('config.lsp-enable')
-- Attempt to load the override LSP enables
-- pcall(require, 'config.override.lsp-enable')

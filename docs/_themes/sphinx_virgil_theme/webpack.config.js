const path = require('path');
const webpack = require('webpack');

const PROD  = process.env.NODE_ENV === 'production';
const DEV   = process.env.NODE_ENV === 'development';

module.exports = {
	debug: DEV,
	devtool: DEV  ? 'eval' : 'source-map',
	entry: './src/js/main.js',
	output: {
		path: path.join(__dirname, (PROD ? 'dist' : '_build'), 'static/js/'),
		filename: !PROD ? 'bundle.min.js' : 'bundle.js'
	},
	plugins: !PROD ? [
		new webpack.optimize.UglifyJsPlugin({
			compress: {
				warnings: false,
			},
			output: {
				comments: false,
			},
		})
	] : [

	],

	module: {
		loaders: [
			{
				test: /\.js$/,
				include: path.join(__dirname, 'src/js'),
				loader: 'babel-loader',
				query: {
					presets: ['es2015']
				}
			}
		]
	}
};

# author: Jordan Bourak & Tiffany Timbers
# date: 2021-11-22

all: results/horse_pops_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_sd.csv \
	reports/qmd_example.html \
	reports/qmd_example.pdf

# generate figures and objects for report
results/horse_pops_plot_largest_sd.png results/horse_pops_plot.png results/horses_sd.csv: source/generate_figures.py
	python source/generate_figures.py --input_dir="data/00030067-eng.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF and set up docs for GitHub Pages
reports/qmd_example.html: results/horse_pops_plot.png reports/qmd_example.qmd
	quarto render reports/qmd_example.qmd --to html
	mkdir -p docs
	cp reports/qmd_example.html docs/index.html
	cp -r results docs/results

reports/qmd_example.pdf: results/horse_pops_plot.png reports/qmd_example.qmd
	quarto render reports/qmd_example.qmd --to pdf
	cp reports/qmd_example.pdf docs/qmd_example.pdf

# clean
clean:
	rm -rf results
	rm -rf docs
	rm -rf reports/qmd_example.html \
		reports/qmd_example.pdf \
		reports/qmd_example_files
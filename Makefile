# Regenerate and publish the boochtek plugin from canonical ~/.config/ai.
#
# Source of truth is ~/.config/ai (override with CONFIG_AI); this repo is a
# generated downstream copy. Items ship when their frontmatter has
# `publish: true`. See bin/generate.py.

.PHONY: generate publish

generate:  ## Regenerate plugins/ from canonical (publish:true items)
	python3 bin/generate.py

publish: generate  ## Regenerate, then commit and push if anything changed
	git add -A
	git diff --cached --quiet || git commit -m "Regenerate plugin from canonical"
	git push

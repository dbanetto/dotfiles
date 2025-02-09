all:
	stow --verbose --target=$$HOME --restow */

adopt:
	stow --adopt --verbose --target=$$HOME --restow */

simulate:
	stow --verbose --simulate --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

# hemnet mini app - by Christopher Loessl

This app downloads a simple JSON file from the internet. It uses a Result<T> type to do all actions that can fail. It's the same idea as functional use a `maybe` type for the same purpose.
For all the image handling I use `SDWebImage` which gives me cache handling of images without any extra code. I cancle image downloads in the `prepareForReuse()` function so it won't happen if the user scrolls fast that a slow image replaces a fast one that was requested at a later point in time.
I might have have implemented the cell in a different way if there was more time available. Probably with dependency injection into the VC, but this approach gave me easy peasy toggle between the two design with a nice animation inbetween with little code. So that's a win.
Further I wouldn't have used `alpha` to grey the items but would have used a `UIView` for that purpose, but then the animation would have been not so easy in this case.

Batteries are also included (comes with a unit test). Weirdly the JSON parsing was the thing I assumed to take 10 min and took with 45 min longer than I had antacipated. Lots of slow copy and paste of JSON fields into code.
Further I had to do small adaptions to the JSON file that was provided. 2 Links didn't point to images but pointed to webpages (nothing else was changed in the JSON).

Other cut corner because of time constraints: I didn't use correct localisation for strings (but hard coded strings) and not correct localisations for numeral values like `dag`/`dagar`.

All downloads of images/JSON are done on a background thread.

If you just want to have a quick look at the app, there is a short video in the repository as well.


Afterthoughts:
- Maybe I should have used another `didSet` on the `design` property¿
- Result/Either types rock
- The project uses Carthage but I included the libary in the checkout
- The project compiles without warings


Feel free to come back with any questions you might have.

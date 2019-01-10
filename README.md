<h1 align="center">
<b>GitHubViewer</b>
   <br><img width="275" height="500" src="https://user-images.githubusercontent.com/16679908/51001049-ce7b1e00-14fc-11e9-89d5-b9d295145380.gif">
</h1>

## Using GitHub API and show list of repos for a given organization or user

Using UICollectionView to toggle display format from grid to list.

No third-party frameworks used.

API endpoint - https://api.github.com/users/apple/repos?page=1&per_page=10  where "apple", "page", per_page are input variables.

Scrolling is used to detect if the request for next page is needed.

- The MVMV is used as code structure.
- The networking is done with URLSSession.
- The JSONSerialization is done with Codable protocol.
- The ScrollViewCell uses StackView to spread the text fields.

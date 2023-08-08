import praw

reddit = praw.Reddit(
    client_id="5o-udDXPcaZdu9PBKeMWnQ",
    client_secret="eZ8MZTWeVAocK4mK2JeHhBVT2XuZ2A",
    user_agent="bug_makers",
)

subreddit = reddit.subreddit("all")  # search all of Reddit
for post in subreddit.search("migrants in Ireland", limit=100):
    print(post.title, post.id)
    
post = reddit.submission(id="POST_ID")
post.comments.replace_more(limit=None)  # fetch all comments
for comment in post.comments.list():
    print(comment.body)
    
keywords = ["migrants", "Ireland", "immigration"]  # your keywords
subreddit = reddit.subreddit("all")
for comment in subreddit.comments(limit=1000):  # get the mostrecent comments
    if any(keyword in comment.body.lower() for keyword in keywords):
        print(comment.body)
        
with open("comments.txt", "w") as file:
    for comment in subreddit.comments(limit=1000):
        if any(keyword in comment.body.lower() for keyword in keywords):
            file.write(comment.body + "\n")
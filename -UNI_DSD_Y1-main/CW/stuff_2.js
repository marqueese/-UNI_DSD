import { useState } from 'react';

export default function CarRepairForum() {
  const [posts, setPosts] = useState([
    {
      id: 1,
      title: "Engine knocking noise when accelerating",
      content: "I'm hearing a knocking sound from the engine when I press the accelerator. It's more noticeable at higher speeds. Any ideas what could be causing this?",
      author: "You",
      timestamp: "2 hours ago",
      image: null,
      make: "Toyota",
      model: "Camry",
      year: "2015",
      category: "Engine Problems",
      replies: [
        {
          id: 1,
          content: "Sounds like it could be piston slap or rod knock. I'd recommend checking the oil level first.",
          author: "Tom Mechanic",
          timestamp: "1 hour ago"
        },
        {
          id: 2,
          content: "Could also be carbon buildup. Try adding some quality fuel injector cleaner to your tank.",
          author: "You",
          timestamp: "45 minutes ago"
        }
      ]
    },
    {
      id: 2,
      title: "Brake pedal feels soft and spongy",
      content: "My brake pedal has become increasingly soft over the past week. I have to press it almost to the floor to stop the car. What should I check first?",
      author: "Sarah Williams",
      timestamp: "1 day ago",
      image: null,
      make: "Honda",
      model: "Civic",
      year: "2018",
      category: "Brake Issues",
      replies: [
        {
          id: 1,
          content: "This sounds like air in the brake lines. You'll need to bleed your brakes.",
          author: "You",
          timestamp: "22 hours ago"
        }
      ]
    }
  ]);

  const [newPost, setNewPost] = useState({
    title: '',
    content: '',
    image: null,
    make: '',
    model: '',
    year: '',
    category: ''
  });

  const [imagePreview, setImagePreview] = useState(null);
  const [replyContents, setReplyContents] = useState({});
  const [expandedPostId, setExpandedPostId] = useState(null);
  const [errors, setErrors] = useState({});
  const [replyErrors, setReplyErrors] = useState({});
  const [activeTab, setActiveTab] = useState('forum');
  const [notifications, setNotifications] = useState([
    { id: 1, message: "Tom Mechanic replied to your post: Engine knocking noise when accelerating", timestamp: "1 hour ago", read: false },
    { id: 2, message: "Your reply to Brake pedal feels soft and spongy was marked as helpful", timestamp: "3 hours ago", read: false },
    { id: 3, message: "New response to: Engine knocking noise when accelerating", timestamp: "5 hours ago", read: true },
    { id: 4, message: "Welcome to AutoRepair Forum! Check out our community guidelines", timestamp: "1 day ago", read: true }
  ]);

  const categories = [
    "Engine Problems",
    "Brake Issues",
    "Electrical Systems",
    "Tire & Wheel",
    "Transmission",
    "Suspension",
    "Cooling System",
    "Exhaust System",
    "Other"
  ];

  const partStores = [
    { name: "AutoZone", url: "https://www.autozone.com" },
    { name: "O'Reilly Auto Parts", url: "https://www.oreillyauto.com" },
    { name: "Advance Auto Parts", url: "https://www.advanceautoparts.com" },
    { name: "NAPA Auto Parts", url: "https://www.napaonline.com" },
    { name: "Canadian Tire", url: "https://www.canadiantire.ca" }
  ];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewPost(prev => ({
      ...prev,
      [name]: value
    }));
    
    // Clear error when user starts typing
    if (errors[name]) {
      setErrors(prev => ({
        ...prev,
        [name]: ''
      }));
    }
  };

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setNewPost(prev => ({
        ...prev,
        image: file
      }));
      
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result);
      };
      reader.readAsDataURL(file);
    }
  };

  const validateForm = () => {
    const newErrors = {};
    
    if (!newPost.title.trim()) {
      newErrors.title = 'Title is required';
    }
    
    if (!newPost.content.trim()) {
      newErrors.content = 'Description is required';
    }
    
    if (!newPost.category) {
      newErrors.category = 'Please select a category';
    }
    
    if (!newPost.make.trim()) {
      newErrors.make = 'Make is required';
    }
    
    if (!newPost.model.trim()) {
      newErrors.model = 'Model is required';
    }
    
    if (!newPost.year.trim()) {
      newErrors.year = 'Year is required';
    } else if (!/^\d{4}$/.test(newPost.year)) {
      newErrors.year = 'Please enter a valid 4-digit year';
    } else if (parseInt(newPost.year) < 1900 || parseInt(newPost.year) > new Date().getFullYear() + 1) {
      newErrors.year = 'Please enter a valid year';
    }
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    if (validateForm()) {
      const post = {
        id: posts.length + 1,
        title: newPost.title,
        content: newPost.content,
        author: "You",
        timestamp: "Just now",
        image: imagePreview,
        make: newPost.make,
        model: newPost.model,
        year: newPost.year,
        category: newPost.category,
        replies: []
      };
      
      setPosts([post, ...posts]);
      setNewPost({ 
        title: '', 
        content: '', 
        image: null, 
        make: '', 
        model: '', 
        year: '', 
        category: '' 
      });
      setImagePreview(null);
      setErrors({});
    }
  };

  const handleReplyChange = (postId, value) => {
    setReplyContents(prev => ({
      ...prev,
      [postId]: value
    }));
    
    // Clear error when user starts typing
    if (replyErrors[postId]) {
      setReplyErrors(prev => ({
        ...prev,
        [postId]: ''
      }));
    }
  };

  const validateReply = (postId) => {
    const replyContent = replyContents[postId];
    if (!replyContent || !replyContent.trim()) {
      setReplyErrors(prev => ({
        ...prev,
        [postId]: 'Reply content is required'
      }));
      return false;
    }
    return true;
  };

  const handleAddReply = (postId) => {
    if (validateReply(postId)) {
      const replyContent = replyContents[postId];
      setPosts(prevPosts => 
        prevPosts.map(post => {
          if (post.id === postId) {
            const newReply = {
              id: post.replies.length + 1,
              content: replyContent,
              author: "You",
              timestamp: "Just now"
            };
            return {
              ...post,
              replies: [...post.replies, newReply]
            };
          }
          return post;
        })
      );
      
      setReplyContents(prev => ({
        ...prev,
        [postId]: ''
      }));
      
      setReplyErrors(prev => ({
        ...prev,
        [postId]: ''
      }));
    }
  };

  const toggleReplies = (postId) => {
    setExpandedPostId(expandedPostId === postId ? null : postId);
  };

  // Delete a post
  const handleDeletePost = (postId) => {
    if (window.confirm("Are you sure you want to delete this post?")) {
      setPosts(posts.filter(post => post.id !== postId));
    }
  };

  // Delete a reply
  const handleDeleteReply = (postId, replyId) => {
    if (window.confirm("Are you sure you want to delete this reply?")) {
      setPosts(prevPosts => 
        prevPosts.map(post => {
          if (post.id === postId) {
            return {
              ...post,
              replies: post.replies.filter(reply => reply.id !== replyId)
            };
          }
          return post;
        })
      );
    }
  };

  // Mark notification as read
  const markAsRead = (id) => {
    setNotifications(notifications.map(notification => 
      notification.id === id ? { ...notification, read: true } : notification
    ));
  };

  // Mark all notifications as read
  const markAllAsRead = () => {
    setNotifications(notifications.map(notification => ({ ...notification, read: true })));
  };

  // Calculate popular topics
  const popularTopics = categories.map(category => {
    const count = posts.filter(post => post.category === category).length;
    return { category, count };
  }).sort((a, b) => b.count - a.count).slice(0, 5);

  // Count unread notifications
  const unreadCount = notifications.filter(n => !n.read).length;

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Header */}
      <header className="bg-gradient-to-r from-blue-800 to-blue-600 text-white shadow-lg">
        <div className="container mx-auto px-4 py-4">
          <div className="flex flex-col md:flex-row justify-between items-center">
            <div className="flex items-center mb-4 md:mb-0">
              <h1 className="text-3xl font-bold">AutoRepair Forum</h1>
            </div>
            
            <div className="flex items-center space-x-6">
              <nav className="flex space-x-4">
                <button
                  onClick={() => setActiveTab('forum')}
                  className={`px-3 py-2 rounded-md font-medium ${
                    activeTab === 'forum'
                      ? 'bg-blue-700 text-white'
                      : 'text-blue-200 hover:text-white hover:bg-blue-700'
                  }`}
                >
                  Forum
                </button>
                <button
                  onClick={() => setActiveTab('notifications')}
                  className={`px-3 py-2 rounded-md font-medium relative ${
                    activeTab === 'notifications'
                      ? 'bg-blue-700 text-white'
                      : 'text-blue-200 hover:text-white hover:bg-blue-700'
                  }`}
                >
                  Notifications
                  {unreadCount > 0 && (
                    <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                      {unreadCount}
                    </span>
                  )}
                </button>
              </nav>
              
              <button className="bg-white text-blue-700 hover:bg-blue-50 font-semibold py-2 px-4 rounded-lg transition duration-300">
                Join Community
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      {activeTab === 'forum' && (
        <div 
          className="relative bg-cover bg-center py-16 px-4"
          style={{ backgroundImage: `url('https://static.vecteezy.com/system/resources/thumbnails/040/247/288/small/ai-generated-a-metal-blank-tabletop-with-blurred-automotive-tools-and-parts-in-the-background-suitable-for-promoting-automotive-products-free-photo.jpg')` }}
        >
          <div className="absolute inset-0 bg-black opacity-50"></div>
          <div className="container mx-auto relative z-10 text-center">
            <h2 className="text-4xl font-bold text-white mb-4">Got a car problem?</h2>
            <p className="text-xl text-white max-w-2xl mx-auto">
              Share your repair questions with our community of mechanics and car enthusiasts
            </p>
          </div>
        </div>
      )}

      <div className="container mx-auto px-4 py-8">
        {activeTab === 'forum' ? (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            {/* Main Content */}
            <div className="lg:col-span-2">
              {/* New Post Form */}
              <div className="bg-white rounded-lg shadow-md p-6 mb-8">
                <h2 className="text-2xl font-bold text-gray-800 mb-4">Ask a Question</h2>
                <form onSubmit={handleSubmit}>
                  <div className="mb-4">
                    <label htmlFor="title" className="block text-gray-700 font-medium mb-2">
                      Title
                    </label>
                    <input
                      type="text"
                      id="title"
                      name="title"
                      value={newPost.title}
                      onChange={handleInputChange}
                      className={`w-full px-3 py-2 border ${
                        errors.title ? 'border-red-500' : 'border-gray-300'
                      } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                      placeholder="Briefly describe your issue..."
                    />
                    {errors.title && (
                      <p className="mt-1 text-red-500 text-sm">{errors.title}</p>
                    )}
                  </div>
                  
                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                    <div>
                      <label htmlFor="make" className="block text-gray-700 font-medium mb-2">
                        Make
                      </label>
                      <input
                        type="text"
                        id="make"
                        name="make"
                        value={newPost.make}
                        onChange={handleInputChange}
                        className={`w-full px-3 py-2 border ${
                          errors.make ? 'border-red-500' : 'border-gray-300'
                        } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                        placeholder="e.g. Toyota"
                      />
                      {errors.make && (
                        <p className="mt-1 text-red-500 text-sm">{errors.make}</p>
                      )}
                    </div>
                    
                    <div>
                      <label htmlFor="model" className="block text-gray-700 font-medium mb-2">
                        Model
                      </label>
                      <input
                        type="text"
                        id="model"
                        name="model"
                        value={newPost.model}
                        onChange={handleInputChange}
                        className={`w-full px-3 py-2 border ${
                          errors.model ? 'border-red-500' : 'border-gray-300'
                        } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                        placeholder="e.g. Camry"
                      />
                      {errors.model && (
                        <p className="mt-1 text-red-500 text-sm">{errors.model}</p>
                      )}
                    </div>
                    
                    <div>
                      <label htmlFor="year" className="block text-gray-700 font-medium mb-2">
                        Year
                      </label>
                      <input
                        type="text"
                        id="year"
                        name="year"
                        value={newPost.year}
                        onChange={handleInputChange}
                        className={`w-full px-3 py-2 border ${
                          errors.year ? 'border-red-500' : 'border-gray-300'
                        } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                        placeholder="e.g. 2015"
                      />
                      {errors.year && (
                        <p className="mt-1 text-red-500 text-sm">{errors.year}</p>
                      )}
                    </div>
                  </div>
                  
                  <div className="mb-4">
                    <label htmlFor="category" className="block text-gray-700 font-medium mb-2">
                      Category
                    </label>
                    <select
                      id="category"
                      name="category"
                      value={newPost.category}
                      onChange={handleInputChange}
                      className={`w-full px-3 py-2 border ${
                        errors.category ? 'border-red-500' : 'border-gray-300'
                      } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                    >
                      <option value="">Select a category</option>
                      {categories.map(category => (
                        <option key={category} value={category}>{category}</option>
                      ))}
                    </select>
                    {errors.category && (
                      <p className="mt-1 text-red-500 text-sm">{errors.category}</p>
                    )}
                  </div>
                  
                  <div className="mb-4">
                    <label htmlFor="content" className="block text-gray-700 font-medium mb-2">
                      Description
                    </label>
                    <textarea
                      id="content"
                      name="content"
                      value={newPost.content}
                      onChange={handleInputChange}
                      rows="4"
                      className={`w-full px-3 py-2 border ${
                        errors.content ? 'border-red-500' : 'border-gray-300'
                      } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                      placeholder="Provide details about your car issue..."
                    ></textarea>
                    {errors.content && (
                      <p className="mt-1 text-red-500 text-sm">{errors.content}</p>
                    )}
                  </div>
                  
                  <div className="mb-4">
                    <label className="block text-gray-700 font-medium mb-2">
                      Add Image (optional)
                    </label>
                    <div className="flex items-center space-x-4">
                      <label className="flex flex-col items-center justify-center w-32 h-32 border-2 border-dashed border-gray-300 rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100">
                        {imagePreview ? (
                          <img 
                            src={imagePreview} 
                            alt="Preview" 
                            className="w-full h-full object-cover rounded-lg"
                          />
                        ) : (
                          <div className="flex flex-col items-center justify-center pt-5 pb-6">
                            <svg className="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                            </svg>
                            <p className="text-xs text-gray-500 mt-2">Upload image</p>
                          </div>
                        )}
                        <input 
                          type="file" 
                          className="hidden" 
                          accept="image/*"
                          onChange={handleImageChange}
                        />
                      </label>
                      {imagePreview && (
                        <button
                          type="button"
                          onClick={() => {
                            setImagePreview(null);
                            setNewPost(prev => ({ ...prev, image: null }));
                          }}
                          className="text-red-500 hover:text-red-700"
                        >
                          Remove Image
                        </button>
                      )}
                    </div>
                  </div>
                  
                  <button
                    type="submit"
                    className="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-md transition duration-300"
                  >
                    Post Question
                  </button>
                </form>
              </div>

              {/* Forum Posts */}
              <div>
                <h2 className="text-2xl font-bold text-gray-800 mb-4">Recent Questions</h2>
                
                {posts.map(post => (
                  <div key={post.id} className="bg-white rounded-lg shadow-md p-6 mb-6">
                    <div className="flex justify-between items-start">
                      <div>
                        <h3 className="text-xl font-bold text-gray-800 mb-1">{post.title}</h3>
                        <div className="flex flex-wrap gap-2 mb-3">
                          <span className="bg-blue-100 text-blue-800 text-xs font-semibold px-2 py-1 rounded">
                            {post.category}
                          </span>
                          <span className="bg-gray-100 text-gray-800 text-xs font-semibold px-2 py-1 rounded">
                            {post.make} {post.model} {post.year}
                          </span>
                        </div>
                      </div>
                      <div className="flex items-center space-x-2">
                        {post.author === "You" && (
                          <button 
                            onClick={() => handleDeletePost(post.id)}
                            className="text-red-500 hover:text-red-700"
                          >
                            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                            </svg>
                          </button>
                        )}
                        <button 
                          onClick={() => toggleReplies(post.id)}
                          className="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded flex items-center"
                        >
                          <span>{post.replies.length} {post.replies.length === 1 ? 'reply' : 'replies'}</span>
                          <svg 
                            className={`w-4 h-4 ml-1 transform transition-transform ${expandedPostId === post.id ? 'rotate-180' : ''}`} 
                            fill="none" 
                            stroke="currentColor" 
                            viewBox="0 0 24 24" 
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 9l-7 7-7-7"></path>
                          </svg>
                        </button>
                      </div>
                    </div>
                    
                    <div className="flex items-center text-sm text-gray-500 mb-4">
                      <span>By {post.author}</span>
                      <span className="mx-2">•</span>
                      <span>{post.timestamp}</span>
                    </div>
                    
                    <p className="text-gray-700 mb-4">{post.content}</p>
                    
                    {post.image && (
                      <div className="mb-4">
                        <img 
                          src={post.image} 
                          alt="Post illustration" 
                          className="w-full max-w-md rounded-lg border border-gray-200"
                        />
                      </div>
                    )}
                    
                    {/* Replies Section */}
                    {expandedPostId === post.id && (
                      <div className="mt-6 pt-4 border-t border-gray-200">
                        <h4 className="font-semibold text-gray-800 mb-3">Replies</h4>
                        
                        <div className="space-y-4 mb-4">
                          {post.replies.map(reply => (
                            <div key={reply.id} className="bg-gray-50 rounded-lg p-4 relative">
                              {reply.author === "You" && (
                                <button 
                                  onClick={() => handleDeleteReply(post.id, reply.id)}
                                  className="absolute top-2 right-2 text-red-500 hover:text-red-700"
                                >
                                  <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                  </svg>
                                </button>
                              )}
                              <div className="flex justify-between">
                                <span className="font-medium text-gray-800">{reply.author}</span>
                                <span className="text-xs text-gray-500">{reply.timestamp}</span>
                              </div>
                              <p className="mt-2 text-gray-700">{reply.content}</p>
                            </div>
                          ))}
                        </div>
                        
                        <div className="mt-4">
                          <textarea
                            value={replyContents[post.id] || ''}
                            onChange={(e) => handleReplyChange(post.id, e.target.value)}
                            rows="2"
                            className={`w-full px-3 py-2 border ${
                              replyErrors[post.id] ? 'border-red-500' : 'border-gray-300'
                            } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500`}
                            placeholder="Write your reply..."
                          ></textarea>
                          {replyErrors[post.id] && (
                            <p className="mt-1 text-red-500 text-sm">{replyErrors[post.id]}</p>
                          )}
                          <button
                            onClick={() => handleAddReply(post.id)}
                            className="mt-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-1 px-4 rounded-md text-sm transition duration-300"
                          >
                            Post Reply
                          </button>
                        </div>
                      </div>
                    )}
                    
                    <div className="flex space-x-3">
                      <button 
                        onClick={() => toggleReplies(post.id)}
                        className="text-blue-600 hover:text-blue-800 font-medium"
                      >
                        {expandedPostId === post.id ? 'Hide Replies' : 'View Replies'}
                      </button>
                      <button className="text-gray-500 hover:text-gray-700 font-medium">
                        Share
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Sidebar */}
            <div>
              <div className="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 className="text-lg font-bold text-gray-800 mb-4">Popular Topics</h3>
                <ul className="space-y-2">
                  {popularTopics.map(topic => (
                    <li key={topic.category}>
                      <a href="#" className="text-blue-600 hover:text-blue-800 flex justify-between">
                        <span>{topic.category}</span>
                        <span className="bg-gray-200 text-gray-800 text-xs font-semibold px-2 py-0.5 rounded">
                          {topic.count}
                        </span>
                      </a>
                    </li>
                  ))}
                </ul>
              </div>

              <div className="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 className="text-lg font-bold text-gray-800 mb-4">Car Parts Stores</h3>
                <ul className="space-y-2">
                  {partStores.map(store => (
                    <li key={store.name}>
                      <a 
                        href={store.url} 
                        target="_blank" 
                        rel="noopener noreferrer"
                        className="text-blue-600 hover:text-blue-800 flex items-center"
                      >
                        <span>{store.name}</span>
                        <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                        </svg>
                      </a>
                    </li>
                  ))}
                </ul>
              </div>

              <div className="bg-white rounded-lg shadow-md p-6">
                <h3 className="text-lg font-bold text-gray-800 mb-4">Forum Rules</h3>
                <ul className="space-y-2 text-sm text-gray-600">
                  <li className="flex items-start">
                    <span className="text-green-500 mr-2">✓</span>
                    <span>Be respectful to all members</span>
                  </li>
                  <li className="flex items-start">
                    <span className="text-green-500 mr-2">✓</span>
                    <span>Provide as much detail as possible</span>
                  </li>
                  <li className="flex items-start">
                    <span className="text-green-500 mr-2">✓</span>
                    <span>Include images when relevant</span>
                  </li>
                  <li className="flex items-start">
                    <span className="text-green-500 mr-2">✓</span>
                    <span>Search before posting</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        ) : (
          // Notifications Tab
          <div className="bg-white rounded-lg shadow-md p-6">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-2xl font-bold text-gray-800">Notifications</h2>
              {unreadCount > 0 && (
                <button
                  onClick={markAllAsRead}
                  className="text-blue-600 hover:text-blue-800 font-medium"
                >
                  Mark all as read
                </button>
              )}
            </div>
            
            {notifications.length === 0 ? (
              <div className="text-center py-12">
                <svg className="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
                </svg>
                <h3 className="mt-2 text-lg font-medium text-gray-900">No notifications</h3>
                <p className="mt-1 text-gray-500">You're all caught up!</p>
              </div>
            ) : (
              <div className="space-y-4">
                {notifications.map(notification => (
                  <div 
                    key={notification.id} 
                    className={`p-4 rounded-lg border ${
                      notification.read 
                        ? 'bg-gray-50 border-gray-200' 
                        : 'bg-blue-50 border-blue-200'
                    }`}
                  >
                    <div className="flex justify-between">
                      <p className={`font-medium ${notification.read ? 'text-gray-800' : 'text-blue-800'}`}>
                        {notification.message}
                      </p>
                      {!notification.read && (
                        <button 
                          onClick={() => markAsRead(notification.id)}
                          className="text-blue-600 hover:text-blue-800 text-sm"
                        >
                          Mark as read
                        </button>
                      )}
                    </div>
                    <p className="text-sm text-gray-500 mt-1">{notification.timestamp}</p>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
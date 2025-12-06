import { useState } from 'react';

export default function JimCarreyPresident() {
  const [email, setEmail] = useState('');
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (email) {
      setSubmitted(true);
      setEmail('');
      setTimeout(() => setSubmitted(false), 3000);
    }
  };

  // Famous Jim Carrey character images
  const characterImages = [
    "https://preview.redd.it/bruce-almighty-2003-its-not-as-good-as-ace-ventura-the-mask-v0-p9j6pfnnx4jb1.jpg?width=640&crop=smart&auto=webp&s=bef84b0f285a4282ad017ccc555e87abb5bf7324",
    "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/03/a-1215.jpg?q=70&fit=crop&w=825&dpr=1",
    "https://static0.srcdn.com/wordpress/wp-content/uploads/2024/05/jim-carrey-as-ace-ventura-from-ace-ventura-pet-detective-and-jim-carrey-as-andy-kaufman-tony-clifton-from-man-on-the-moon.jpg?q=49&fit=crop&w=422&dpr=2",
    "https://m.media-amazon.com/images/M/MV5BZWM2ZjA2OTctZmRhMy00ZDIzLTkwZGQtYTRlNmQwZWZmMDBlXkEyXkFqcGc@.jpg",
    "https://people.com/thmb/ten7zOcCeHVUIArPRVRDBDDXr2s=/4000x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(919x345:921x347)/jim-carey-morgan-freeman-bruce-almighty-112322-37326a82bb834b82b9258bd4e74c6457.jpg",
    "https://b.thumbs.redditmedia.com/fD3lJEh4ZPoNGpdFDbRYPwJ_eDNZ3dw_Lna-6USsjyQ.jpg"
  ];

  // New images for the "Why Jim Carrey" section - political/speaking images
  const leadershipImages = [
    "https://media.cnn.com/api/v1/images/stellar/prod/190117230939-pba-jim-carrey-mejores-peliculas-best-movies.jpg?q=x_0,y_131,h_1419,w_2523,c_crop/h_833,w_1480",
    "https://i.guim.co.uk/img/media/b8b82127830af7f8985cc0cdab3510f2f3c5d617/342_453_2914_1747/master/2914.jpg?width=465&dpr=1&s=none&crop=none",
    "https://external-preview.redd.it/uBITg8AVI_6m22UjGq-BqAT1Uwpc7mihhkmJQvflu5w.jpg?width=640&crop=smart&auto=webp&s=50ff6b0bbc8e13571eaec7feff18db16f31468ab",
    "http://i.imgur.com/0p2Gw.jpg"
  ];

  // Chuck Norris images
  const chuckNorrisImages = [
    "https://i.kym-cdn.com/entries/icons/original/000/000/366/chuck-norris.jpg",
    "https://www.meme-arsenal.com/memes/c05397245eb04b61609386310f970b53.jpg",
    "https://images.immediate.co.uk/production/volatile/sites/3/2022/07/GettyImages-86624047-e1614358490919-48008fc.jpg?quality=90&resize=620,413",
    "https://i.insider.com/50ae6c756bb3f73f7c000029?width=700"
  ];

  const whiteHouseImage = "https://www.whitehouse.gov/wp-content/uploads/2025/07/White-House-State-Ballroom-Exterior-View-from-Southeast.jpeg?w=1200";
  const flagImage = "https://static.vecteezy.com/system/resources/thumbnails/046/860/921/small/waving-flag-of-american-usa-flag-on-a-transparent-background-png.png";

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-900 to-red-800 text-white">
      {/* Header */}
      <header className="relative py-6 px-4 md:px-8">
        <div className="container mx-auto flex flex-col md:flex-row justify-between items-center">
          <div className="flex items-center mb-4 md:mb-0">
            <img src={flagImage} alt="American Flag" className="h-10 mr-3" />
            <h1 className="text-2xl md:text-3xl font-bold">JIM CARREY FOR PRESIDENT</h1>
          </div>
          <nav className="flex space-x-6">
            <a href="#about" className="hover:text-yellow-300 transition">About</a>
            <a href="#characters" className="hover:text-yellow-300 transition">Characters</a>
            <a href="#policies" className="hover:text-yellow-300 transition">Policies</a>
            <a href="#runningmate" className="hover:text-yellow-300 transition">Running Mate</a>
            <a href="#platform" className="hover:text-yellow-300 transition">Platform</a>
            <a href="#support" className="hover:text-yellow-300 transition">Support</a>
          </nav>
        </div>
      </header>

      {/* Hero Section */}
      <section className="relative py-16 px-4 text-center">
        <div className="container mx-auto">
          <h1 className="text-4xl md:text-6xl font-bold mb-6">Make Comedy Great Again!</h1>
          <p className="text-xl md:text-2xl max-w-3xl mx-auto mb-10">
            Elect Jim Carrey - The only president who can make you laugh while solving real problems!
          </p>
          <div className="flex justify-center">
            <img 
              src={characterImages[0]} 
              alt="Jim Carrey" 
              className="rounded-full w-48 h-48 md:w-64 md:h-64 object-cover border-4 border-yellow-400 shadow-2xl"
            />
          </div>
          <div className="mt-10">
            <a 
              href="#support" 
              className="bg-red-600 hover:bg-red-700 text-white font-bold py-3 px-8 rounded-full text-lg transition transform hover:scale-105 inline-block"
            >
              Support Jim 2028
            </a>
          </div>
        </div>
      </section>

      {/* Character Showcase Section */}
      <section id="characters" className="py-16 px-4 bg-blue-800 bg-opacity-50 relative overflow-hidden">
        <div className="container mx-auto">
          <h2 className="text-3xl md:text-4xl font-bold text-center mb-16">Legendary Characters for Legendary Leadership</h2>
          
          {/* Diagonal Character Display */}
          <div className="relative min-h-[600px]">
            {characterImages.map((img, index) => (
              <div 
                key={index}
                className="absolute transform transition-all duration-500 hover:scale-110 hover:z-10"
                style={{
                  top: `${20 + (index * 12)}%`,
                  left: `${10 + (index * 15)}%`,
                  transform: `rotate(${index % 2 === 0 ? -5 : 5}deg)`
                }}
              >
                <div className="relative group">
                  <img 
                    src={img} 
                    alt={`Jim Carrey Character ${index + 1}`}
                    className="w-40 h-52 md:w-52 md:h-64 object-cover rounded-lg shadow-2xl border-4 border-white"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black to-transparent rounded-lg opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-3">
                    <span className="text-white font-bold text-sm md:text-base">
                      {['Bruce Almighty', 'Ace Ventura', 'The Mask', 'Liar Liar', 'The Cable Guy', 'Dumb & Dumber'][index]}
                    </span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* About Section */}
      <section id="about" className="py-16 px-4">
        <div className="container mx-auto">
          <h2 className="text-3xl md:text-4xl font-bold text-center mb-12">Why Jim Carrey?</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
            <div>
              <h3 className="text-2xl font-bold mb-4">America Needs Laughter</h3>
              <p className="mb-4 text-lg">
                After years of political division, we need a leader who can unite us through humor and compassion. 
                Jim has spent decades making us laugh while showing us our shared humanity.
              </p>
              <p className="text-lg">
                As the first comedian president, Jim will bring fresh perspectives to governance, 
                breaking down barriers with his unique brand of truth-telling comedy.
              </p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              {leadershipImages.map((img, index) => (
                <img 
                  key={index} 
                  src={img} 
                  alt={`Jim Carrey Leadership ${index + 1}`} 
                  className="rounded-lg shadow-lg w-full h-48 object-cover"
                />
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Running Mate Announcement */}
      <section id="runningmate" className="py-16 px-4 bg-blue-800 bg-opacity-50">
        <div className="container mx-auto text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-6">ANNOUNCING OUR VICE PRESIDENTIAL CANDIDATE</h2>
          <div className="max-w-4xl mx-auto">
            <div className="bg-red-600 py-4 mb-8 animate-pulse">
              <p className="text-2xl md:text-3xl font-bold">BREAKING: CHUCK NORRIS TO JOIN THE TICKET!</p>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
              <div className="text-left">
                <h3 className="text-2xl font-bold mb-4 text-yellow-300">Chuck Norris - The People's Champion</h3>
                <p className="mb-4 text-lg">
                  In a historic move, Jim Carrey has selected martial arts legend and internet icon Chuck Norris 
                  as his running mate for the 2028 election.
                </p>
                <p className="mb-4 text-lg">
                  "When facts don't matter, Chuck Norris becomes even more relevant," said Carrey. 
                  "Together, we'll bring justice to Washington... with roundhouse kicks!"
                </p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>Unmatched foreign policy experience (he once stared down the Soviet Union)</li>
                  <li>Proven ability to solve complex problems with simple solutions</li>
                  <li>Has never told a lie - facts just rearrange themselves around him</li>
                  <li>Will handle all cabinet meetings with maximum efficiency</li>
                </ul>
              </div>
              
              <div className="grid grid-cols-2 gap-4">
                {chuckNorrisImages.map((img, index) => (
                  <img 
                    key={index} 
                    src={img} 
                    alt={`Chuck Norris ${index + 1}`} 
                    className="rounded-lg shadow-lg w-full h-48 object-cover"
                  />
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Policies Section */}
      <section id="policies" className="py-16 px-4">
        <div className="container mx-auto">
          <h2 className="text-3xl md:text-4xl font-bold text-center mb-12">Jim's Bold Policies</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm border border-white border-opacity-20">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">Universal Comedy Access Act</h3>
              <p className="mb-3">
                Every American deserves access to comedy as a basic right. This act ensures free stand-up shows, 
                improv classes, and comedy clubs in every community.
              </p>
              <div className="mt-4 text-sm">
                <span className="font-bold">Impact:</span> Reduced stress, increased happiness nationwide
              </div>
            </div>
            
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm border border-white border-opacity-20">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">Department of Laughter</h3>
              <p className="mb-3">
                A new federal agency dedicated to promoting joy, reducing stress, and implementing 
                nationwide happiness initiatives with evidence-based humor therapy.
              </p>
              <div className="mt-4 text-sm">
                <span className="font-bold">Impact:</span> Improved mental health outcomes, stronger communities
              </div>
            </div>
            
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm border border-white border-opacity-20">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">International Diplomacy Through Humor</h3>
              <p className="mb-3">
                Replace tense diplomatic negotiations with comedy roasts. International conflicts 
                resolved through professional comedians rather than military action.
              </p>
              <div className="mt-4 text-sm">
                <span className="font-bold">Impact:</span> Peaceful resolutions, stronger global relationships
              </div>
            </div>
            
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm border border-white border-opacity-20">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">Federal Funding for Improv Education</h3>
              <p className="mb-3">
                Every school will receive funding for improv programs to teach creativity, 
                quick thinking, and collaboration to the next generation of leaders.
              </p>
              <div className="mt-4 text-sm">
                <span className="font-bold">Impact:</span> More innovative workforce, better problem-solving skills
              </div>
            </div>
            
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm border border-white border-opacity-20">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">National Clown Program</h3>
              <p className="mb-3">
                Rebrand government workers as "Federal Clowns" to reduce bureaucratic fear. 
                All public service representatives trained in circus arts and comedy.
              </p>
              <div className="mt-4 text-sm">
                <span className="font-bold">Impact:</span> More approachable government, increased civic engagement
              </div>
            </div>
            
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm border border-white border-opacity-20">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">The "Okay" Initiative</h3>
              <p className="mb-3">
                Replace "Have a nice day" with "Have an okay day" to set realistic expectations. 
                National campaign to normalize mediocrity and reduce pressure to excel.
              </p>
              <div className="mt-4 text-sm">
                <span className="font-bold">Impact:</span> Reduced anxiety, improved life satisfaction
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Platform Section */}
      <section id="platform" className="py-16 px-4 bg-blue-800 bg-opacity-50">
        <div className="container mx-auto">
          <h2 className="text-3xl md:text-4xl font-bold text-center mb-12">The Carrey-Norris Platform</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">Universal Happiness Initiative</h3>
              <p>
                A nationwide program to ensure every American has access to comedy, 
                art, and joy as fundamental rights for mental wellbeing.
              </p>
            </div>
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">Eco-Friendly Clown Policy</h3>
              <p>
                Reducing carbon emissions through nationwide laughter yoga programs 
                and transitioning to renewable energy sources with a smile.
              </p>
            </div>
            <div className="bg-white bg-opacity-10 p-6 rounded-xl backdrop-blur-sm">
              <h3 className="text-xl font-bold mb-3 text-yellow-300">Transparent Governance</h3>
              <p>
                Weekly comedy specials from the White House to keep the public informed 
                about government operations in the most entertaining way possible.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* White House Vision */}
      <section className="py-16 px-4">
        <div className="container mx-auto text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-8">A New Kind of White House</h2>
          <div className="relative max-w-4xl mx-auto">
            <img 
              src={whiteHouseImage} 
              alt="White House" 
              className="rounded-xl shadow-2xl w-full h-64 md:h-96 object-cover"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black to-transparent rounded-xl"></div>
            <div className="absolute bottom-6 left-6 text-left">
              <p className="text-2xl font-bold">"The Oval Office will finally be oval!"</p>
              <p className="text-yellow-300">- Jim Carrey (Presumptive)</p>
            </div>
          </div>
        </div>
      </section>

      {/* Support Section */}
      <section id="support" className="py-16 px-4">
        <div className="container mx-auto max-w-3xl text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-6">Join the Movement!</h2>
          <p className="text-xl mb-10">
            Sign up to volunteer and help make history in 2028
          </p>
          
          {submitted ? (
            <div className="bg-green-600 py-6 px-8 rounded-lg">
              <h3 className="text-2xl font-bold">Thank You!</h3>
              <p>You're officially part of the Carrey-Norris movement. Stay tuned for updates!</p>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <input 
                  type="text" 
                  placeholder="First Name" 
                  className="bg-white bg-opacity-20 border border-white rounded-lg py-3 px-4 text-white placeholder-white placeholder-opacity-70 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                  required
                />
                <input 
                  type="text" 
                  placeholder="Last Name" 
                  className="bg-white bg-opacity-20 border border-white rounded-lg py-3 px-4 text-white placeholder-white placeholder-opacity-70 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                  required
                />
              </div>
              <input 
                type="email" 
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Email Address" 
                className="w-full bg-white bg-opacity-20 border border-white rounded-lg py-3 px-4 text-white placeholder-white placeholder-opacity-70 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                required
              />
              <button 
                type="submit" 
                className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-4 px-8 rounded-lg text-lg transition transform hover:scale-105"
              >
                SIGN ME UP FOR JIM & CHUCK!
              </button>
            </form>
          )}
        </div>
      </section>

      {/* Footer */}
      <footer className="py-8 px-4 border-t border-white border-opacity-20">
        <div className="container mx-auto text-center">
          <p className="mb-4">Paid for by the Committee to Make America Laugh Again</p>
          <p className="text-sm opacity-75">This is a parody website created for entertainment purposes only.</p>
        </div>
      </footer>
    </div>
  );
}
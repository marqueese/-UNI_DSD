import { useState } from 'react';

export default function NavalWarfareHistory() {
  const [activeTab, setActiveTab] = useState('overview');

  const timelineEvents = [
    {
      date: 'Ancient Times',
      title: 'Birth of Naval Warfare',
      description: 'Naval battles began with oar-powered vessels in ancient civilizations like Egypt, Greece, and Rome. The Battle of Salamis (480 BCE) showcased early naval tactics.',
    },
    {
      date: '16th-18th Century',
      title: 'Age of Sail',
      description: 'Sailing ships with cannons dominated naval warfare. Key battles include Trafalgar (1805) where Nelson defeated the combined French and Spanish fleets.',
    },
    {
      date: '1860s',
      title: 'Ironclad Era',
      description: 'The Battle of Hampton Roads (1862) marked the first clash of ironclad warships, revolutionizing naval combat.',
    },
    {
      date: '1900s-1945',
      title: 'World Wars',
      description: 'Dreadnoughts, submarines, and aircraft carriers transformed naval warfare. The Battle of Midway (1942) demonstrated the carrier\'s dominance.',
    },
    {
      date: '1945-Present',
      title: 'Nuclear Age',
      description: 'Nuclear-powered submarines and carriers became the backbone of modern naval forces, with stealth technology and precision missiles.',
    },
  ];

  const carriers = [
    {
      name: 'USS Enterprise (CV-6)',
      era: 'WWII',
      description: 'Most decorated US warship of WWII, participated in more major battles than any other ship.',
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/USS_Enterprise_%28CV-6%29_underway_in_July_1944_%28NH_41959%29.jpg/800px-USS_Enterprise_%28CV-6%29_underway_in_July_1944_%28NH_41959%29.jpg'
    },
    {
      name: 'USS Nimitz (CVN-68)',
      era: 'Cold War',
      description: 'Lead ship of the Nimitz class, first nuclear-powered aircraft carrier to be constructed.',
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/USS_Nimitz_%28CVN-68%29_at_sea_in_October_1978_%28NH_104512-KN%29.jpg/800px-USS_Nimitz_%28CVN-68%29_at_sea_in_October_1978_%28NH_104512-KN%29.jpg'
    },
    {
      name: 'USS Gerald R. Ford (CVN-78)',
      era: 'Modern',
      description: 'Latest and most advanced aircraft carrier with enhanced weapons systems and improved flight deck.',
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/USS_Gerald_R._Ford_%28CVN-78%29_at_sea_on_21_August_2021_%28NH_109678-NH%29.jpg/800px-USS_Gerald_R._Ford_%28CVN-78%29_at_sea_on_21_August_2021_%28NH_109678-NH%29.jpg'
    },
  ];

  const warshipTypes = [
    {
      name: 'Battleships',
      description: 'Heavily armored warships with large-caliber guns that dominated naval warfare from the late 19th to mid-20th century. The Yamato class was the largest battleship ever built.',
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/USS_Iowa_%28BB-61%29_shown_offering_a_salute_to_the_Caribbean_island_of_Aruba_during_a_cruise_through_the_region_in_1985.jpg/800px-USS_Iowa_%28BB-61%29_shown_offering_a_salute_to_the_Caribbean_island_of_Aruba_during_a_cruise_through_the_region_in_1985.jpg',
      impact: 'Provided heavy firepower but became vulnerable to air attacks and missiles, leading to their decline after WWII.'
    },
    {
      name: 'Submarines',
      description: 'Stealth underwater vessels that revolutionized naval warfare by attacking from unseen positions. German U-boats nearly brought Britain to its knees in both world wars.',
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/USS_Nautilus_%28SSN-571%29_underway_surface_1955.jpg/800px-USS_Nautilus_%28SSN-571%29_underway_surface_1955.jpg',
      impact: 'Shifted naval strategy to anti-submarine warfare and became crucial for intelligence gathering and nuclear deterrence.'
    },
    {
      name: 'Aircraft Carriers',
      description: 'Mobile airbases that project power across vast distances. The Essex class formed the backbone of US naval aviation during WWII.',
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/USS_Bunker_Hill_%28CV-17%29_off_the_Marianas_on_19_June_1944_%28NH_42071%29.jpg/800px-USS_Bunker_Hill_%28CV-17%29_off_the_Marianas_on_19_June_1944_%28NH_42071%29.jpg',
      impact: 'Completely transformed naval warfare from surface engagements to three-dimensional air combat, making other ship types secondary.'
    }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-gray-100">
      {/* Header */}
      <header className="bg-blue-900 text-white py-16 px-4 relative">
        <div className="max-w-6xl mx-auto text-center relative z-10">
          <h1 className="text-4xl md:text-6xl font-bold mb-4">History of Naval Warfare</h1>
          <p className="text-xl md:text-2xl max-w-3xl mx-auto">
            From ancient galleys to modern aircraft carriers: The evolution of sea combat
          </p>
        </div>
        <div className="absolute inset-0 bg-black opacity-40"></div>
        <div className="absolute inset-0 bg-gradient-to-r from-blue-800 to-teal-700 opacity-70"></div>
      </header>

      {/* Navigation Tabs */}
      <div className="max-w-6xl mx-auto px-4 -mt-8 relative z-20">
        <div className="bg-white rounded-lg shadow-lg p-2">
          <div className="flex flex-wrap justify-center gap-2">
            {['overview', 'timeline', 'carriers', 'warships', 'impact'].map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`px-6 py-3 rounded-lg font-medium capitalize transition-all ${
                  activeTab === tab
                    ? 'bg-blue-600 text-white shadow-md'
                    : 'text-gray-700 hover:bg-gray-100'
                }`}
              >
                {tab}
              </button>
            ))}
          </div>
        </div>
      </div>

      <main className="max-w-6xl mx-auto px-4 py-12">
        {/* Overview Section */}
        {activeTab === 'overview' && (
          <div className="bg-white rounded-xl shadow-lg p-6 md:p-8 mb-12">
            <h2 className="text-3xl font-bold text-gray-800 mb-6">The Evolution of Naval Combat</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 items-center mb-10">
              <div>
                <p className="text-gray-700 mb-4 text-lg">
                  Naval warfare has shaped the course of human history, from ancient naval battles that determined the fate of empires to modern carrier strike groups that project power across the globe.
                </p>
                <p className="text-gray-700 mb-4 text-lg">
                  The introduction of aircraft carriers in the 20th century revolutionized naval combat, shifting the focus from surface engagements to air power projection. Today's nuclear-powered carriers serve as mobile airbases capable of deploying anywhere in the world.
                </p>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <img 
                  src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Battle_of_Salamis_%28D%C3%A9tail%29_by_Wilhelm_von_Kaulbach.jpg/800px-Battle_of_Salamis_%28D%C3%A9tail%29_by_Wilhelm_von_Kaulbach.jpg" 
                  alt="Historical naval battle" 
                  className="rounded-lg shadow-md w-full h-48 object-cover"
                />
                <img 
                  src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/USS_George_H.W._Bush_%28CVN-77%29_flight_deck_operations_May_2011.jpg/800px-USS_George_H.W._Bush_%28CVN-77%29_flight_deck_operations_May_2011.jpg" 
                  alt="Modern aircraft carrier" 
                  className="rounded-lg shadow-md w-full h-48 object-cover mt-8"
                />
              </div>
            </div>

            <div className="bg-blue-50 rounded-xl p-6 border border-blue-100">
              <h3 className="text-2xl font-semibold text-blue-800 mb-4">Key Transformations</h3>
              <ul className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <li className="flex items-start">
                  <div className="bg-blue-500 rounded-full p-2 mr-3">
                    <svg className="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                  </div>
                  <span className="text-gray-700"><strong>Wood to Steel:</strong> Transition from wooden sailing ships to armored steel warships</span>
                </li>
                <li className="flex items-start">
                  <div className="bg-blue-500 rounded-full p-2 mr-3">
                    <svg className="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                  </div>
                  <span className="text-gray-700"><strong>Guns to Missiles:</strong> Evolution from cannon broadsides to precision-guided weapons</span>
                </li>
                <li className="flex items-start">
                  <div className="bg-blue-500 rounded-full p-2 mr-3">
                    <svg className="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                  </div>
                  <span className="text-gray-700"><strong>Surface to Air:</strong> Aircraft carriers transformed naval combat to three-dimensional warfare</span>
                </li>
              </ul>
            </div>
          </div>
        )}

        {/* Timeline Section */}
        {activeTab === 'timeline' && (
          <div className="bg-white rounded-xl shadow-lg p-6 md:p-8 mb-12">
            <h2 className="text-3xl font-bold text-gray-800 mb-8 text-center">Evolution of Naval Warfare</h2>
            
            <div className="relative">
              {/* Timeline line */}
              <div className="absolute left-4 md:left-1/2 top-0 bottom-0 w-1 bg-blue-200 transform -translate-x-1/2"></div>
              
              {timelineEvents.map((event, index) => (
                <div 
                  key={index} 
                  className={`mb-12 flex flex-col ${index % 2 === 0 ? 'md:flex-row' : 'md:flex-row-reverse'} items-center`}
                >
                  <div className="md:w-1/2 mb-4 md:mb-0">
                    <div className={`p-6 rounded-lg shadow-md ${index % 2 === 0 ? 'md:mr-8' : 'md:ml-8'}`}>
                      <span className="inline-block px-3 py-1 text-sm font-semibold text-blue-700 bg-blue-100 rounded-full mb-2">
                        {event.date}
                      </span>
                      <h3 className="text-xl font-bold text-gray-800 mb-2">{event.title}</h3>
                      <p className="text-gray-600">{event.description}</p>
                    </div>
                  </div>
                  
                  <div className="md:w-1/2 flex justify-center">
                    <div className="relative">
                      <div className="w-8 h-8 rounded-full bg-blue-600 border-4 border-white shadow-lg flex items-center justify-center z-10 relative"></div>
                    </div>
                  </div>
                  
                  <div className="md:w-1/2"></div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Aircraft Carriers Section */}
        {activeTab === 'carriers' && (
          <div className="bg-white rounded-xl shadow-lg p-6 md:p-8 mb-12">
            <h2 className="text-3xl font-bold text-gray-800 mb-8 text-center">Aircraft Carriers: Masters of the Seas</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
              <div className="bg-gradient-to-br from-blue-50 to-cyan-50 rounded-xl p-6 border border-blue-100">
                <div className="text-5xl font-bold text-blue-600 mb-2">1920s</div>
                <h3 className="text-xl font-bold text-gray-800 mb-3">First Carriers</h3>
                <p className="text-gray-600">
                  HMS Argus and USS Langley pioneered aircraft carrier design, converting existing ships to launch biplanes.
                </p>
              </div>
              
              <div className="bg-gradient-to-br from-blue-100 to-indigo-100 rounded-xl p-6 border border-blue-200">
                <div className="text-5xl font-bold text-blue-700 mb-2">1940s</div>
                <h3 className="text-xl font-bold text-gray-800 mb-3">WWII Revolution</h3>
                <p className="text-gray-600">
                  Battle of Midway proved carrier supremacy. Essex-class carriers became the backbone of US naval aviation.
                </p>
              </div>
              
              <div className="bg-gradient-to-br from-blue-200 to-indigo-200 rounded-xl p-6 border border-blue-300">
                <div className="text-5xl font-bold text-blue-800 mb-2">Today</div>
                <h3 className="text-xl font-bold text-gray-800 mb-3">Nuclear Power</h3>
                <p className="text-gray-600">
                  Ford-class carriers represent the pinnacle of naval engineering with unprecedented capabilities.
                </p>
              </div>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {carriers.map((carrier, index) => (
                <div key={index} className="bg-gray-50 rounded-xl overflow-hidden shadow-md hover:shadow-lg transition-shadow">
                  <img 
                    src={carrier.image} 
                    alt={carrier.name}
                    className="w-full h-48 object-cover"
                  />
                  <div className="p-6">
                    <span className="inline-block px-3 py-1 text-sm font-semibold text-blue-700 bg-blue-100 rounded-full mb-3">
                      {carrier.era}
                    </span>
                    <h3 className="text-xl font-bold text-gray-800 mb-2">{carrier.name}</h3>
                    <p className="text-gray-600">{carrier.description}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Warships Section */}
        {activeTab === 'warships' && (
          <div className="bg-white rounded-xl shadow-lg p-6 md:p-8 mb-12">
            <h2 className="text-3xl font-bold text-gray-800 mb-8 text-center">Evolution of Naval Vessels</h2>
            
            <div className="mb-12">
              <h3 className="text-2xl font-bold text-gray-800 mb-6 text-center">How Aircraft Carriers Changed Naval Warfare</h3>
              <div className="bg-blue-50 rounded-xl p-6 border border-blue-100">
                <p className="text-gray-700 mb-4 text-lg">
                  The introduction of aircraft carriers fundamentally transformed naval warfare by shifting the focus from surface engagements to air power projection. Before carriers, naval battles were fought at close range with large guns. Carriers extended the reach of naval forces hundreds of miles, making them the centerpiece of modern naval strategy.
                </p>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-6">
                  <div className="bg-white p-4 rounded-lg shadow">
                    <h4 className="font-bold text-blue-700 mb-2">Extended Reach</h4>
                    <p className="text-gray-600">Aircraft can strike targets far beyond the horizon, extending naval power projection capabilities.</p>
                  </div>
                  <div className="bg-white p-4 rounded-lg shadow">
                    <h4 className="font-bold text-blue-700 mb-2">Strategic Flexibility</h4>
                    <p className="text-gray-600">Carriers can rapidly reposition and respond to threats anywhere within their operational range.</p>
                  </div>
                  <div className="bg-white p-4 rounded-lg shadow">
                    <h4 className="font-bold text-blue-700 mb-2">Force Multiplier</h4>
                    <p className="text-gray-600">A single carrier can project the equivalent air power of multiple land-based airfields.</p>
                  </div>
                </div>
              </div>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {warshipTypes.map((warship, index) => (
                <div key={index} className="bg-gray-50 rounded-xl overflow-hidden shadow-md hover:shadow-lg transition-shadow">
                  <img 
                    src={warship.image} 
                    alt={warship.name}
                    className="w-full h-48 object-cover"
                  />
                  <div className="p-6">
                    <h3 className="text-xl font-bold text-gray-800 mb-2">{warship.name}</h3>
                    <p className="text-gray-600 mb-4">{warship.description}</p>
                    <div className="bg-blue-50 p-4 rounded-lg border border-blue-100">
                      <h4 className="font-bold text-blue-700 mb-2">Impact on Naval Warfare</h4>
                      <p className="text-gray-700">{warship.impact}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Impact Section */}
        {activeTab === 'impact' && (
          <div className="bg-white rounded-xl shadow-lg p-6 md:p-8 mb-12">
            <h2 className="text-3xl font-bold text-gray-800 mb-8 text-center">Global Impact of Naval Warfare</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
              <div className="bg-blue-50 rounded-xl p-6 border border-blue-100">
                <h3 className="text-2xl font-bold text-blue-800 mb-4">Strategic Importance</h3>
                <p className="text-gray-700 mb-4">
                  Naval power has determined the fate of nations throughout history. Control of the seas enables:
                </p>
                <ul className="space-y-2">
                  <li className="flex items-start">
                    <svg className="w-5 h-5 text-blue-500 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Protection of trade routes and economic interests</span>
                  </li>
                  <li className="flex items-start">
                    <svg className="w-5 h-5 text-blue-500 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Projection of military power across continents</span>
                  </li>
                  <li className="flex items-start">
                    <svg className="w-5 h-5 text-blue-500 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Deterrence of potential aggressors</span>
                  </li>
                </ul>
              </div>
              
              <div className="bg-teal-50 rounded-xl p-6 border border-teal-100">
                <h3 className="text-2xl font-bold text-teal-800 mb-4">Technological Advancements</h3>
                <p className="text-gray-700 mb-4">
                  Naval warfare has driven innovation in multiple fields:
                </p>
                <ul className="space-y-2">
                  <li className="flex items-start">
                    <svg className="w-5 h-5 text-teal-500 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Metallurgy and shipbuilding techniques</span>
                  </li>
                  <li className="flex items-start">
                    <svg className="w-5 h-5 text-teal-500 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Radar, sonar, and communications systems</span>
                  </li>
                  <li className="flex items-start">
                    <svg className="w-5 h-5 text-teal-500 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Nuclear propulsion and advanced materials</span>
                  </li>
                </ul>
              </div>
            </div>
            
            <div className="bg-gradient-to-r from-blue-600 to-indigo-700 rounded-xl p-8 text-white">
              <h3 className="text-2xl font-bold mb-4">Modern Naval Power</h3>
              <p className="mb-4 text-lg">
                Today's aircraft carriers serve as floating cities with over 5,000 personnel aboard, capable of launching coordinated air operations anywhere in the world within 72 hours.
              </p>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
                <div className="bg-white bg-opacity-20 rounded-lg p-4">
                  <div className="text-3xl font-bold">100,000+</div>
                  <div className="text-sm">Tons displacement</div>
                </div>
                <div className="bg-white bg-opacity-20 rounded-lg p-4">
                  <div className="text-3xl font-bold">80+</div>
                  <div className="text-sm">Aircraft capacity</div>
                </div>
                <div className="bg-white bg-opacity-20 rounded-lg p-4">
                  <div className="text-3xl font-bold">30+</div>
                  <div className="text-sm">Knots top speed</div>
                </div>
                <div className="bg-white bg-opacity-20 rounded-lg p-4">
                  <div className="text-3xl font-bold">50+</div>
                  <div className="text-sm">Years service life</div>
                </div>
              </div>
            </div>
          </div>
        )}
      </main>

      {/* Footer */}
      <footer className="bg-gray-800 text-white py-12 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <h3 className="text-xl font-bold mb-4">Naval History</h3>
              <p className="text-gray-300">
                Exploring the evolution of naval warfare from ancient times to modern aircraft carriers.
              </p>
            </div>
            <div>
              <h3 className="text-xl font-bold mb-4">Key Topics</h3>
              <ul className="space-y-2 text-gray-300">
                <li>Ancient Naval Battles</li>
                <li>Age of Sail</li>
                <li>World Wars at Sea</li>
                <li>Modern Carrier Operations</li>
              </ul>
            </div>
            <div>
              <h3 className="text-xl font-bold mb-4">Resources</h3>
              <ul className="space-y-2 text-gray-300">
                <li>Naval Museums</li>
                <li>Historical Archives</li>
                <li>Documentaries</li>
                <li>Academic Research</li>
              </ul>
            </div>
          </div>
          <div className="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
            <p>© 2023 Naval Warfare History. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
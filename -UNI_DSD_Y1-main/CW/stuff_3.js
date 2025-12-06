import { useState } from 'react';

export default function ComponentLibrary() {
  const [activeTab, setActiveTab] = useState('hero');
  const [copiedComponent, setCopiedComponent] = useState(null);

  // Sample data for cards
  const cardData = [
    { title: "Project Alpha", description: "A revolutionary approach to solving everyday problems with innovative solutions.", imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/008/740/772/small/team-of-business-people-working-together-in-the-meeting-room-office-teamwork-background-charts-and-graphs-banner-double-exposure-successful-teamwork-business-planning-concept-free-photo.jpg" },
    { title: "Project Beta", description: "Streamlining workflows through automation and intelligent design patterns.", imageUrl: "https://thumbs.dreamstime.com/b/teamwork-business-team-meeting-unity-jigsaw-puzzle-concept-47350521.jpg" },
    { title: "Project Gamma", description: "Creating sustainable solutions for tomorrow's challenges today.", imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/008/740/851/small/team-of-business-people-working-together-in-the-meeting-room-office-teamwork-background-charts-and-graphs-banner-double-exposure-successful-teamwork-business-planning-concept-free-photo.jpg" }
  ];

  const testimonialData = [
    { name: "Alex Johnson", role: "Product Manager", quote: "This component library saved us weeks of development time." },
    { name: "Sarah Williams", role: "UX Designer", quote: "Clean, accessible, and beautifully designed components." },
    { name: "Michael Chen", role: "Frontend Developer", quote: "The best collection of ready-to-use React components I've found." }
  ];

  const copyToClipboard = (code) => {
    navigator.clipboard.writeText(code);
    setCopiedComponent(code.substring(0, 30));
    setTimeout(() => setCopiedComponent(null), 2000);
  };

  const HeroSection = () => `
<div className="relative bg-gradient-to-r from-blue-500 to-indigo-700 text-white overflow-hidden">
  <div className="max-w-7xl mx-auto">
    <div className="relative z-10 pb-8 sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32">
      <main className="mt-10 mx-auto max-w-7xl px-4 sm:mt-12 sm:px-6 md:mt-16 lg:mt-20 lg:px-8 xl:mt-28">
        <div className="sm:text-center lg:text-left">
          <h1 className="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
            <span className="block">Ready-to-use</span>
            <span className="block text-indigo-200">React Components</span>
          </h1>
          <p className="mt-3 text-base sm:mt-5 sm:text-lg sm:max-w-xl sm:mx-auto md:mt-5 md:text-xl lg:mx-0">
            Beautifully designed, fully responsive React components built with Tailwind CSS. Copy and paste directly into your projects.
          </p>
          <div className="mt-5 sm:mt-8 sm:flex sm:justify-center lg:justify-start">
            <div className="rounded-md shadow">
              <a href="#components" className="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-gray-50 md:py-4 md:text-lg md:px-10">
                Browse Components
              </a>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
  <div className="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2">
    <div className="h-56 w-full bg-gray-200 sm:h-72 md:h-96 lg:w-full lg:h-full bg-gradient-to-r from-blue-400 to-indigo-600"></div>
  </div>
</div>`;

  const CardGrid = () => `
<div className="grid grid-cols-1 md:grid-cols-3 gap-8">
  ${cardData.map((card, index) => `
  <div key={${index}} className="bg-white rounded-xl shadow-md overflow-hidden transition-transform duration-300 hover:scale-105">
    <div className="h-48 bg-gray-200">
      <img 
        src="${card.imageUrl}" 
        alt="${card.title}" 
        className="w-full h-full object-cover"
      />
    </div>
    <div className="p-6">
      <h3 className="text-xl font-bold text-gray-900 mb-2">${card.title}</h3>
      <p className="text-gray-600">${card.description}</p>
      <button className="mt-4 px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 transition-colors">
        Learn More
      </button>
    </div>
  </div>
  `).join('')}
</div>`;

  const TestimonialSection = () => `
<div className="bg-gray-50 py-16">
  <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div className="text-center">
      <h2 className="text-3xl font-extrabold text-gray-900">What People Are Saying</h2>
      <p className="mt-4 max-w-2xl text-xl text-gray-500 mx-auto">
        Don't just take our word for it - hear from our community
      </p>
    </div>
    <div className="mt-16">
      <div className="grid grid-cols-1 gap-8 md:grid-cols-3">
        ${testimonialData.map((testimonial, index) => `
        <div key={${index}} className="bg-white p-6 rounded-lg shadow-sm">
          <div className="flex items-center">
            <div className="flex-shrink-0">
              <div className="h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center">
                <span className="text-indigo-800 font-bold">{${
                  testimonial.name
                    .split(" ")
                    .map((n) => n[0])
                    .join("")
                }}</span>
              </div>
            </div>
            <div className="ml-4">
              <h4 className="text-lg font-bold text-gray-900">${testimonial.name}</h4>
              <p className="text-indigo-600">${testimonial.role}</p>
            </div>
          </div>
          <p className="mt-4 text-gray-600 italic">"${testimonial.quote}"</p>
        </div>
        `).join('')}
      </div>
    </div>
  </div>
</div>`;

  const CTASection = () => `
<div className="bg-indigo-700">
  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:py-16 lg:px-8 lg:flex lg:items-center lg:justify-between">
    <h2 className="text-3xl font-extrabold tracking-tight text-white sm:text-4xl">
      <span className="block">Ready to dive in?</span>
      <span className="block text-indigo-200">Start using these components today.</span>
    </h2>
    <div className="mt-8 flex lg:mt-0 lg:flex-shrink-0">
      <div className="inline-flex rounded-md shadow">
        <a
          href="#"
          className="inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-indigo-50"
        >
          Get started
        </a>
      </div>
    </div>
  </div>
</div>`;

  const components = [
    { id: 'hero', name: 'Hero Section', code: HeroSection() },
    { id: 'cards', name: 'Card Grid', code: CardGrid() },
    { id: 'testimonials', name: 'Testimonials', code: TestimonialSection() },
    { id: 'cta', name: 'CTA Section', code: CTASection() }
  ];

  const activeComponent = components.find(c => c.id === activeTab);

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16 items-center">
            <div className="flex items-center">
              <h1 className="text-2xl font-bold text-indigo-600">ReactComponentHub</h1>
              <nav className="ml-10 flex space-x-8">
                <a href="#" className="border-indigo-500 text-gray-900 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                  Components
                </a>
                <a href="https://react.dev" target="_blank" rel="noopener noreferrer" className="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                  React Docs
                </a>
                <a href="https://tailwindcss.com" target="_blank" rel="noopener noreferrer" className="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                  Tailwind CSS
                </a>
              </nav>
            </div>
            <div>
              <button className="bg-indigo-600 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-indigo-700">
                Get Started
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section Preview */}
      <section className="relative bg-gradient-to-r from-blue-500 to-indigo-700 text-white overflow-hidden">
        <div className="max-w-7xl mx-auto">
          <div className="relative z-10 pb-8 sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32">
            <main className="mt-10 mx-auto max-w-7xl px-4 sm:mt-12 sm:px-6 md:mt-16 lg:mt-20 lg:px-8 xl:mt-28">
              <div className="sm:text-center lg:text-left">
                <h1 className="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
                  <span className="block">Ready-to-use</span>
                  <span className="block text-indigo-200">React Components</span>
                </h1>
                <p className="mt-3 text-base sm:mt-5 sm:text-lg sm:max-w-xl sm:mx-auto md:mt-5 md:text-xl lg:mx-0">
                  Beautifully designed, fully responsive React components built with Tailwind CSS. Copy and paste directly into your projects.
                </p>
                <div className="mt-5 sm:mt-8 sm:flex sm:justify-center lg:justify-start">
                  <div className="rounded-md shadow">
                    <a 
                      href="#components" 
                      className="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-gray-50 md:py-4 md:text-lg md:px-10"
                    >
                      Browse Components
                    </a>
                  </div>
                </div>
              </div>
            </main>
          </div>
        </div>
        <div className="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2">
          <div className="h-56 w-full bg-gray-200 sm:h-72 md:h-96 lg:w-full lg:h-full bg-gradient-to-r from-blue-400 to-indigo-600"></div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-12 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <h2 className="text-3xl font-extrabold text-gray-900">Why Our Components?</h2>
            <p className="mt-4 max-w-2xl text-xl text-gray-500 mx-auto">
              Built for developers who want to move fast without sacrificing quality
            </p>
          </div>
          <div className="mt-10">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div className="text-center">
                <div className="mx-auto flex items-center justify-center h-12 w-12 rounded-md bg-indigo-500 text-white">
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
                  </svg>
                </div>
                <h3 className="mt-5 text-lg font-medium text-gray-900">Lightning Fast</h3>
                <p className="mt-2 text-base text-gray-500">
                  Pre-built components that save hours of development time. Just copy, paste, and customize.
                </p>
              </div>
              <div className="text-center">
                <div className="mx-auto flex items-center justify-center h-12 w-12 rounded-md bg-indigo-500 text-white">
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
                  </svg>
                </div>
                <h3 className="mt-5 text-lg font-medium text-gray-900">Fully Customizable</h3>
                <p className="mt-2 text-base text-gray-500">
                  Each component is easily customizable with Tailwind's utility classes to match your brand.
                </p>
              </div>
              <div className="text-center">
                <div className="mx-auto flex items-center justify-center h-12 w-12 rounded-md bg-indigo-500 text-white">
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                  </svg>
                </div>
                <h3 className="mt-5 text-lg font-medium text-gray-900">Accessible & Responsive</h3>
                <p className="mt-2 text-base text-gray-500">
                  All components follow accessibility standards and work perfectly on all device sizes.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Components Section */}
      <section id="components" className="py-12 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <h2 className="text-3xl font-extrabold text-gray-900">Prebuilt Components</h2>
            <p className="mt-4 max-w-2xl text-xl text-gray-500 mx-auto">
              Copy and paste these components directly into your React projects
            </p>
          </div>

          {/* Tabs */}
          <div className="mt-10">
            <div className="border-b border-gray-200">
              <nav className="-mb-px flex space-x-8 overflow-x-auto">
                {components.map((component) => (
                  <button
                    key={component.id}
                    onClick={() => setActiveTab(component.id)}
                    className={`whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm ${
                      activeTab === component.id
                        ? 'border-indigo-500 text-indigo-600'
                        : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                    }`}
                  >
                    {component.name}
                  </button>
                ))}
              </nav>
            </div>

            {/* Component Preview and Code */}
            <div className="mt-8 bg-white rounded-lg shadow overflow-hidden">
              <div className="p-6 border-b border-gray-200">
                <div className="flex justify-between items-center">
                  <h3 className="text-lg font-medium text-gray-900">{activeComponent?.name}</h3>
                  <button
                    onClick={() => copyToClipboard(activeComponent?.code)}
                    className="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none"
                  >
                    {copiedComponent === activeComponent?.code.substring(0, 30) ? 'Copied!' : 'Copy Code'}
                  </button>
                </div>
              </div>
              
              <div className="p-6">
                <pre className="overflow-x-auto bg-gray-800 text-gray-100 p-4 rounded-md text-sm">
                  <code>{activeComponent?.code}</code>
                </pre>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Testimonials */}
      <section className="bg-gray-50 py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <h2 className="text-3xl font-extrabold text-gray-900">What People Are Saying</h2>
            <p className="mt-4 max-w-2xl text-xl text-gray-500 mx-auto">
              Don't just take our word for it - hear from our community
            </p>
          </div>
          <div className="mt-16">
            <div className="grid grid-cols-1 gap-8 md:grid-cols-3">
              <div className="bg-white p-6 rounded-lg shadow-sm">
                <div className="flex items-center">
                  <div className="flex-shrink-0">
                    <div className="h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center">
                      <span className="text-indigo-800 font-bold">AJ</span>
                    </div>
                  </div>
                  <div className="ml-4">
                    <h4 className="text-lg font-bold text-gray-900">Alex Johnson</h4>
                    <p className="text-indigo-600">Product Manager</p>
                  </div>
                </div>
                <p className="mt-4 text-gray-600 italic">"This component library saved us weeks of development time."</p>
              </div>
              
              <div className="bg-white p-6 rounded-lg shadow-sm">
                <div className="flex items-center">
                  <div className="flex-shrink-0">
                    <div className="h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center">
                      <span className="text-indigo-800 font-bold">SW</span>
                    </div>
                  </div>
                  <div className="ml-4">
                    <h4 className="text-lg font-bold text-gray-900">Sarah Williams</h4>
                    <p className="text-indigo-600">UX Designer</p>
                  </div>
                </div>
                <p className="mt-4 text-gray-600 italic">"Clean, accessible, and beautifully designed components."</p>
              </div>
              
              <div className="bg-white p-6 rounded-lg shadow-sm">
                <div className="flex items-center">
                  <div className="flex-shrink-0">
                    <div className="h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center">
                      <span className="text-indigo-800 font-bold">MC</span>
                    </div>
                  </div>
                  <div className="ml-4">
                    <h4 className="text-lg font-bold text-gray-900">Michael Chen</h4>
                    <p className="text-indigo-600">Frontend Developer</p>
                  </div>
                </div>
                <p className="mt-4 text-gray-600 italic">"The best collection of ready-to-use React components I've found."</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="bg-indigo-700">
        <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:py-16 lg:px-8 lg:flex lg:items-center lg:justify-between">
          <h2 className="text-3xl font-extrabold tracking-tight text-white sm:text-4xl">
            <span className="block">Ready to dive in?</span>
            <span className="block text-indigo-200">Start using these components today.</span>
          </h2>
          <div className="mt-8 flex lg:mt-0 lg:flex-shrink-0">
            <div className="inline-flex rounded-md shadow">
              <a
                href="#"
                className="inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-indigo-50"
              >
                Get started
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-white">
        <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            <div>
              <h3 className="text-sm font-semibold text-gray-500 tracking-wider uppercase">Resources</h3>
              <ul className="mt-4 space-y-4">
                <li><a href="https://react.dev" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">React Documentation</a></li>
                <li><a href="https://tailwindcss.com" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">Tailwind CSS</a></li>
                <li><a href="https://github.com/facebook/react" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">React GitHub</a></li>
                <li><a href="https://stackoverflow.com/questions/tagged/reactjs" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">React Support</a></li>
              </ul>
            </div>
            <div>
              <h3 className="text-sm font-semibold text-gray-500 tracking-wider uppercase">Learning</h3>
              <ul className="mt-4 space-y-4">
                <li><a href="https://react.dev/learn/tutorial-tic-tac-toe" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">React Tutorial</a></li>
                <li><a href="https://tailwindcss.com/docs" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">Tailwind Docs</a></li>
                <li><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">JavaScript Guide</a></li>
                <li><a href="https://developer.mozilla.org/en-US/docs/Web/CSS" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">CSS Reference</a></li>
              </ul>
            </div>
            <div>
              <h3 className="text-sm font-semibold text-gray-500 tracking-wider uppercase">Community</h3>
              <ul className="mt-4 space-y-4">
                <li><a href="https://github.com/" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">GitHub</a></li>
                <li><a href="https://discord.com/invite/reactiflux" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">React Discord</a></li>
                <li><a href="https://stackoverflow.com/" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">Stack Overflow</a></li>
                <li><a href="https://dev.to/t/react" target="_blank" rel="noopener noreferrer" className="text-base text-gray-500 hover:text-gray-900">DEV Community</a></li>
              </ul>
            </div>
            <div>
              <h3 className="text-sm font-semibold text-gray-500 tracking-wider uppercase">Legal</h3>
              <ul className="mt-4 space-y-4">
                <li><a href="#" className="text-base text-gray-500 hover:text-gray-900">Privacy Policy</a></li>
                <li><a href="#" className="text-base text-gray-500 hover:text-gray-900">Terms of Service</a></li>
                <li><a href="#" className="text-base text-gray-500 hover:text-gray-900">Cookie Policy</a></li>
              </ul>
            </div>
          </div>
          <div className="mt-12 border-t border-gray-200 pt-8">
            <p className="text-base text-gray-400 text-center">&copy; 2023 ReactComponentHub. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
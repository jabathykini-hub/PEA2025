import { useState } from "react";

export default function Home() {
  const categories = [
    "ARTIST OF THE YEAR",
    "Best New Artist of the Year",
    "Comedian of the Year",
    "Producer of the Year",
    "Video Director of the Year",
    "Diaspora Artist of the Year",
    "Best Male Radio Personality of the Year",
    "Online Promoter of the Year",
    "Collaboration of the Year",
    "Afro Pop Artist",
    "Hipco Artist Song of the Year",
    "Song Of the Year",
    "Dance Crew of the Year",
    "Best Gospel Artist of the Year",
    "Actor of the Year",
    "Actress of the Year",
    "Female Artist of the Year",
    "Male Artist of the Year",
    "Content Creator of the Year",
    "Blog of the Year",
    "Radio Station of the Year",
    "Artist to Watch Out For",
    "Video of the Year",
    "Graphic Designer of the Year",
    "Best Female Radio Personality",
    "Trapco Artist of the Year",
    "Best Social Media Influencer of the Year",
    "Best Club DJ of the Year",
    "Best Radio DJ and Promoter",
    "BEST MC of the Year",
    "Lifetime Achievement Award"
  ];

  const [selectedCategory, setSelectedCategory] = useState("");
  const [nomineeName, setNomineeName] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!selectedCategory || !nomineeName) return alert("Please select a category and enter a name.");
    setSubmitted(true);
    setTimeout(() => {
      setSelectedCategory("");
      setNomineeName("");
      setSubmitted(false);
    }, 3000);
  };

  return (
    <div style={{ textAlign: "center", fontFamily: "Arial, sans-serif", padding: "40px" }}>
      <h1>🏆 PEA 2025–2026 Nominee Portal</h1>
      <p>Submit your nomination below for your favorite talents:</p>
      <form onSubmit={handleSubmit} style={{ marginTop: "20px", display: "inline-block", textAlign: "left", padding: "20px", border: "1px solid #ccc", borderRadius: "10px", background: "#fafafa" }}>
        <label><b>Select Category:</b></label><br/>
        <select value={selectedCategory} onChange={(e) => setSelectedCategory(e.target.value)} style={{ width: "100%", padding: "10px", marginTop: "5px", marginBottom: "15px" }}>
          <option value="">-- Choose a Category --</option>
          {categories.map((cat, i) => (<option key={i} value={cat}>{cat}</option>))}
        </select>
        <label><b>Nominee Name:</b></label><br/>
        <input type="text" value={nomineeName} onChange={(e) => setNomineeName(e.target.value)} placeholder="Enter nominee's name" style={{ width: "100%", padding: "10px", marginTop: "5px", marginBottom: "15px" }} />
        <button type="submit" style={{ width: "100%", padding: "12px", backgroundColor: "#0070f3", color: "#fff", border: "none", borderRadius: "6px", cursor: "pointer", fontSize: "16px" }}>Submit Nomination</button>
        {submitted && (<p style={{ marginTop: "15px", color: "green", fontWeight: "bold" }}>✅ Thank you! Your nomination has been submitted.</p>)}
      </form>
      <p style={{ marginTop: "40px" }}>Powered by <b>Paynesville Entertainment Awards (PEA) 2025–2026</b>.</p>
    </div>
  );
}

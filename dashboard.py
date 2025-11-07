import streamlit as st
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Title
st.title("🧾  Commit Sales Data Dashboard")

# --- Peak Transaction Hours ---
st.header("Peak Transaction Hours Analysis ⏰")

# Load the aggregated data for peak hours
@st.cache_data
def load_peak_hours_data():
    
    df_peak = pd.read_csv("Peak Transaction hours.csv", decimal=',')
    
    df_peak['total_sales'] = df_peak['total_sales'].astype(float)
    
    df_peak = df_peak.sort_values(by='transaction_hour', ascending=True)
    return df_peak

df_peak_hours = load_peak_hours_data()

# 1. Create the figure using matplotlib
fig, ax = plt.subplots(figsize=(10, 5))
sns.lineplot(
    data=df_peak_hours,
    x='transaction_hour', 
    y='total_sales',      
    ax=ax,
    marker='o',
    color='darkblue'
)


# Set titles and labels
ax.set_title("Total Sales by Hour of Day", fontsize=16)
ax.set_xlabel("Hour of Day (24h Clock)", fontsize=12)
ax.set_ylabel("Total Sales Amount", fontsize=12)
ax.set_xticks(df_peak_hours['transaction_hour'])
plt.tight_layout()

# 2. Display the Matplotlib figure in Streamlit
st.pyplot(fig)


# --- Best Products Per Store ---
st.header("Best Product by Store Location 🛒")

# Load the best product data
@st.cache_data
def load_best_product_data():
    # Load the CSV, explicitly telling Pandas to use ',' as the decimal separator.
    df_best = pd.read_csv("Best product per store.csv", decimal=',')
    
    # Ensure the sales column is treated as a float after loading
    df_best['total_sales'] = df_best['total_sales'].astype(float)
    
    return df_best

df_best_product = load_best_product_data()

# Show the data in a clean, interactive table
st.subheader("Top Product Insight Table")
st.dataframe(df_best_product, use_container_width=True)

# 1. Create the figure
fig2, ax2 = plt.subplots(figsize=(10, 6))

# Plot total_sales against store_location
sns.barplot(
    data=df_best_product,
    x='total_sales', 
    y='store_location',
    hue='product_detail', 
    ax=ax2,
    palette='Spectral' 
)


# Add labels to the bars (optional, but good for clarity on small datasets)
for container in ax2.containers:
    ax2.bar_label(container, fmt='%.2f')

# Set titles and labels
ax2.set_title("Total Sales of Top Product per Store", fontsize=16)
ax2.set_xlabel("Total Sales Amount", fontsize=12)
ax2.set_ylabel("Store Location", fontsize=12)
plt.legend(title='Best Product Detail', bbox_to_anchor=(1.05, 1), loc='upper left')
plt.tight_layout()

# 2. Display the Matplotlib figure in Streamlit
st.pyplot(fig2)


# --- Product Revenue Ranking & Visualization ---
st.header("Product Revenue Ranking 🥇")

# Load the aggregated data for product ranks
@st.cache_data
def load_product_rank_data():
    
    df_rank = pd.read_csv("Revenue per Product with Rank and Category Share.csv", decimal=',')
    
    # Ensure the sales and share columns are treated as floats
    df_rank['total_sales'] = df_rank['total_sales'].astype(float)
    df_rank['category_total'] = df_rank['category_total'].astype(float)
    df_rank['category_share'] = df_rank['category_share'].astype(float)
    
    # Filter to show only the top 5 products in each category for clean visualization
    df_rank_top = df_rank[df_rank['rank_in_category'] <= 5]
    
    return df_rank, df_rank_top

df_rank_full, df_rank_top = load_product_rank_data()

# --- 1. Top N Products per Category (Grouped Bar Chart) ---
st.subheader("Top 5 Products by Sales Share within Each Category")

fig3, ax3 = plt.subplots(figsize=(12, 8))
sns.barplot(
    data=df_rank_top,
    x='category_share',
    y='product_detail',
    hue='product_category',
    ax=ax3,
    dodge=False,
    palette='deep'
)


# Set titles and labels
ax3.set_title("Category Contribution of Top Products", fontsize=16)
ax3.set_xlabel("Category Share (%)", fontsize=12)
ax3.set_ylabel("Product Detail", fontsize=12)

# Move legend out of the plot area
plt.legend(title='Product Category', bbox_to_anchor=(1.05, 1), loc='upper left')
plt.tight_layout()

st.pyplot(fig3)

# --- 2. Full Rank Table (Recommendation) ---
st.subheader("Full Product Sales Rank Table")

# Display the full ranked data for detailed viewing, using Streamlit's expander for neatness
with st.expander("Click to view full product ranking"):
    # Select and format key columns for the table
    display_cols = df_rank_full[['rank_in_category', 'product_category', 'product_detail', 'total_sales', 'category_share']].copy()
    
    # Format the numbers for readability
    display_cols['total_sales'] = display_cols['total_sales'].map('${:,.2f}'.format)
    display_cols['category_share'] = display_cols['category_share'].map('{:,.2f}%'.format)
    
    st.dataframe(
        display_cols.rename(columns={'rank_in_category': 'Rank', 'total_sales': 'Total Revenue', 'category_share': 'Category Share'}),
        use_container_width=True
    )



# --- Best Selling Products Overall ---
st.header("Overall Best Selling Products 🏆")

# Load the aggregated data for best selling products
@st.cache_data
def load_best_selling_data():
    # Load the CSV, explicitly telling Pandas to use ',' as the decimal separator.
    df_best_selling = pd.read_csv("CTE.csv", decimal=',')
    
    # Ensure the sales column is treated as a float
    df_best_selling['total_sales'] = df_best_selling['total_sales'].astype(float)
    
    # Filter to show only the top 15 products for visualization
    df_top_15 = df_best_selling[df_best_selling['sales_rank'] <= 15]
    
    return df_best_selling, df_top_15

df_best_selling_full, df_top_15 = load_best_selling_data()

# --- 1. Top 15 Products Bar Chart ---
st.subheader("Top 15 Products by Total Sales")

fig4, ax4 = plt.subplots(figsize=(10, 7))

# Create a horizontal bar chart
sns.barplot(
    data=df_top_15,
    x='total_sales',
    y='product_detail',
    ax=ax4,
    palette='Reds_r' # Use a gradient color map for a clean look
)


# Set titles and labels
ax4.set_title("Top 15 Products by Revenue", fontsize=16)
ax4.set_xlabel("Total Sales Amount", fontsize=12)
ax4.set_ylabel("Product Detail", fontsize=12)

# Add value labels to the bars
for container in ax4.containers:
    ax4.bar_label(container, fmt='${:,.2f}')

plt.tight_layout()

# Display the Matplotlib figure in Streamlit
st.pyplot(fig4)

# --- 2. Full Rank Table (Recommendation) ---
st.subheader("Full Best Selling Products Table")

# Display the full ranked data for detailed viewing, using Streamlit's expander
with st.expander("Click to view full list of all 52 ranked products"):
    # Format the 'total_sales' column for currency display
    display_cols = df_best_selling_full.copy()
    display_cols['total_sales'] = display_cols['total_sales'].map('${:,.2f}'.format)
    
    st.dataframe(
        display_cols.rename(columns={'sales_rank': 'Rank', 'product_detail': 'Product Name', 'total_sales': 'Total Revenue'}),
        use_container_width=True
    )
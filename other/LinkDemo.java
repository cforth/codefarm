class Link {
    private class Node {
        private Object data;
        private Node next;
        public Node(Object data) {
            this.data = data;
        }
        public void addNode(Node newNode) {
            if(this.next == null) {
                this.next = newNode;
            } else {
                this.next.addNode(newNode);
            }
        }
        public boolean containsNode(Object data) {
            if(data.equals(this.data)) {
                return true;
            } else {
                if(this.next != null) {
                    return this.next.containsNode(data);
                } else {
                    return false;
                }
            }
        }
        public Object getNode(int index) {
            if (Link.this.foot++ == index) {
                return this.data;
            } else {
                return this.next.getNode(index);
            }
        }
        public void setNode(int index, Object data) {
            if (Link.this.foot++ == index) {
                this.data = data;
            } else {
                this.next.setNode(index, data);
            }
        }
        public void removeNode(Node previous, Object data) {
            if(data.equals(this.data)) {
                previous.next = this.next;
            } else {
                this.next.removeNode(this, data);
            }
        }
        public void toArrayNode() {
            Link.this.retArray[Link.this.foot++] =  this.data;
            if (this.next != null) {
                this.next.toArrayNode();
            }
        }
    }
    //===========以上为内部类=========
    private Node root;
    private int count = 0;
    private int foot = 0;
    private Object [] retArray;
    public void add(Object data) {
        if(data == null) { //不允许有null
            return;
        }
        Node newNode = new Node(data);
        if(this.root == null) {
            this.root = newNode;
        } else {
            this.root.addNode(newNode);
        }
        this.count++;
    }
    public int size() {
        return this.count;
    }
    public boolean isEmpty() {
        return this.count == 0;
    }
    public boolean contains(Object data) {
        if(data == null || this.root == null) {
            return false;
        }
        return this.root.containsNode(data);
    }
    public Object get(int index) {
        if(index > this.count) {
            return null;
        }
        this.foot = 0;
        return this.root.getNode(index);
    }
    public void set(int index, Object data) {
        if(index > this.count) {
            return;
        }
        this.foot = 0;
        this.root.setNode(index, data);
    }
    public void remove(Object data) {
        if(this.contains(data)) {
            if(data.equals(this.root.data)) {
                this.root = this.root.next;
            } else {
                this.root.next.removeNode(this.root, data);
            }
            this.count--;
        }
    }
    public Object [] toArray() {
        if(this.root == null) {
            return null;
        }
        this.foot = 0;
        this.retArray = new String[this.count];
        this.root.toArrayNode();
        return this.retArray;
    }
}

public class LinkDemo {
    public static void main (String args[]) {
        Link all = new Link();
        System.out.println(all.isEmpty());
        all.add("Hello");
        all.add("World");
        all.add("I");
        all.add(null);
        all.add("am");
        all.add("here");
        System.out.println(all.size());
        System.out.println(all.isEmpty());
        System.out.println(all.contains("Hello"));
        System.out.println(all.contains("sadf"));
        System.out.println(all.get(2));
        System.out.println(all.get(10));
        all.set(2, "you");
        System.out.println(all.get(2));
        all.remove("you");
        System.out.println(all.get(2));
        System.out.println(all.size());
        Object[] data = all.toArray();
        for(int x=0; x<data.length; x++) {
            System.out.println(data[x]);
        }
    }
}
